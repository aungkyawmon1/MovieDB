//
//  MovieModel.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RxSwift

protocol MovieModel {
    func getPopular() -> Observable<[MovieRO]>
    func getUpcoming() -> Observable<[MovieRO]>
    func getMovie(at id: Int) -> Observable<MovieRO?>
    func updateFavorite(id: Int, isFavorite: Bool )
}

class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared: MovieModel = MovieModelImpl()
    
    private let movieRepository: MovieRepository = MovieRepositoryImp.shared
    
    func getPopular() -> Observable<[MovieRO]> {
        let url = ApiConfig.Movie.popular.getUrlString()
        
        APIClient.shared.request(url: url, model: MovieResponse.self).subscribe { [weak self] movieResponse in
            
            guard let self = self else { return }
            guard let movieList = movieResponse?.results else { return }
            movieRepository.saveMovies(movieVOs: movieList, type: .popular)
        }onError: {_ in
            debugPrint("Try Againe")
        }.disposed(by: disposeBag)
        
        return movieRepository.getMovie(type: .popular)
    }
    
    func getUpcoming() -> Observable<[MovieRO]> {
        let url = ApiConfig.Movie.upcoming.getUrlString()
        
        APIClient.shared.request(url: url, model: MovieResponse.self).subscribe { [weak self] movieResponse in
            
            guard let self = self else { return }
            guard let movieList = movieResponse?.results else { return }
            movieRepository.saveMovies(movieVOs: movieList, type: .upcoming)
        }onError: { error in
            debugPrint("Try Again", error.localizedDescription)
        }.disposed(by: disposeBag)
        
        return movieRepository.getMovie(type: .upcoming)
    }
    
    func getMovie(at id: Int) -> Observable<MovieRO?> {
        movieRepository.getMovie(at: id)
    }
    
    func updateFavorite(id: Int, isFavorite: Bool ) {
        movieRepository.updateFavorite(id: id, isFavorite: isFavorite)
    }
    
}
