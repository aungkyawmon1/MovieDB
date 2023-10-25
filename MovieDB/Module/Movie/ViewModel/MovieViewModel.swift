//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RxSwift
import RxRelay

enum MovieType: String {
    case popular
    case upcoming
}

class MovieViewModel: BaseViewModel {
    
    var movieTypeList: [MovieType] = [.upcoming, .popular]
    
    var popularMovies: [MovieRO] = []
    var upComingMovies: [MovieRO] = []
    
    func getMovieType(at index: Int) -> MovieType {
        movieTypeList[index]
    }
    
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    let moviePublishRelay = PublishRelay<[MovieRO]?>()
    
    func getPopular() {
        loadingPublishRelay.accept(true)
        movieModel.getPopular().subscribe(onNext: { movieList in
            self.loadingPublishRelay.accept(false)
            self.popularMovies = movieList
            self.moviePublishRelay.accept(movieList)
        }, onError: { _ in
            self.loadingPublishRelay.accept(false)
            self.errorPublishRelay.accept("Please, try again!")
        }).disposed(by: disposeBag)
    }
    
    func getUpcoming() {
        loadingPublishRelay.accept(true)
        movieModel.getUpcoming().subscribe(onNext: { movieList in
            self.loadingPublishRelay.accept(false)
            self.upComingMovies = movieList
            self.moviePublishRelay.accept(movieList)
        }, onError: { _ in
            self.loadingPublishRelay.accept(false)
            self.errorPublishRelay.accept("Please, try again!")
        }).disposed(by: disposeBag)
    }
    
    func updateFavorite(movieRO: MovieRO) {
        movieModel.updateFavorite(id: movieRO.id ?? 0, isFavorite: !(movieRO.isFavorite ?? false))
    }
    
    
    
    
}
