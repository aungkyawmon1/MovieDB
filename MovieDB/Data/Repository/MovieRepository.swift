//
//  MovieRepository.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RxSwift
import RxRealm

protocol MovieRepository {
    func saveMovies(movieVOs: [MovieVO], type: MovieType)
    func getMovie(type: MovieType) -> Observable<[MovieRO]>
    func getMovie(at id: Int) -> Observable<MovieRO?>
    func updateFavorite(id: Int, isFavorite: Bool )
}

class MovieRepositoryImp: BaseRepository, MovieRepository {
    
    static let shared: MovieRepository = MovieRepositoryImp()
    
    
    func saveMovies(movieVOs: [MovieVO], type: MovieType) {
        movieVOs.forEach { movieVO in
            // Check movie is exist or not.
            if let movieRO = realmInstance.object(ofType: MovieRO.self, forPrimaryKey: movieVO.id ?? 0) {
                //If exist, update the movie attributs only
                do {
                    try realmInstance.write({
                        movieRO.adult = movieVO.adult
                        movieRO.backdropPath = movieVO.backdropPath
                        movieRO.genreIDS.append(objectsIn: movieVO.genreIDS ?? [])
                        movieRO.originalLanguage = movieVO.originalLanguage
                        movieRO.originalTitle = movieVO.originalTitle
                        movieRO.popularity = movieVO.popularity
                        movieRO.posterPath = movieVO.posterPath
                        movieRO.overview = movieVO.overview
                        movieRO.releaseDate = movieVO.releaseDate
                        movieRO.title = movieVO.title
                        movieRO.video = movieVO.video
                        movieRO.voteAverage = movieVO.voteAverage
                        movieRO.voteCount = movieVO.voteCount
                        if !movieRO.movieType.contains(type.rawValue) {
                            movieRO.movieType.append(type.rawValue)
                        }
                    })
                } catch {
                    print(error.localizedDescription)
                }
            
            } else {
                //If not exist, add the movie attributs with default favorite value
                let movieRO = movieVO.convertToRO()
                movieRO.isFavorite = false
                movieRO.movieType.append(type.rawValue)
                do {
                    try realmInstance.write({
                        realmInstance.add(movieRO)
                    })
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Fetch movies based on movie type
    func getMovie(type: MovieType) -> RxSwift.Observable<[MovieRO]> {
        let results = realmInstance.objects(MovieRO.self).filter("ANY movieType CONTAINS[c] %@", type.rawValue)
        return Observable.array(from: results)
    }
    
    func getMovie(at id: Int) -> Observable<MovieRO?> {
        guard let data = realmInstance.object(ofType: MovieRO.self, forPrimaryKey: id) else { return Observable.just(nil) }
        return Observable.from(object: data).map { return $0 }
    }
    
    
    // Update the favorite column
    func updateFavorite(id: Int, isFavorite: Bool ) {
        if let movieRO = realmInstance.object(ofType: MovieRO.self, forPrimaryKey: id) {
            
            do {
                try realmInstance.write({
                    movieRO.isFavorite = isFavorite
                })
            } catch {
                print(error.localizedDescription)
            }
        
        }
    }
    
    
}


