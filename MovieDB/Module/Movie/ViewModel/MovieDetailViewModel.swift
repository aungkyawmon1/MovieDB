//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailViewModel : BaseViewModel {
    
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    private let movieID : Int
    
    private var movieRO: MovieRO?
    
    let moviePublishRelay = PublishRelay<MovieRO?>()
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    func getDetail() {
        movieModel.getMovie(at: movieID).subscribe(onNext: { movieRO in
            self.movieRO = movieRO
            self.moviePublishRelay.accept(movieRO)
        }).disposed(by: disposeBag)
    }
    
    func updateFavorite() {
        guard let movieRO = movieRO else { return }
        movieModel.updateFavorite(id: movieRO.id ?? 0, isFavorite: !(movieRO.isFavorite ?? false))
    }
    
    
}
