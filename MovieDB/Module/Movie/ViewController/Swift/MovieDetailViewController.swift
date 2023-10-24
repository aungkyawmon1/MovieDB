//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var ivMoviePhoto: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var viewModel: MovieDetailViewModel!
    
    var favoriteButton : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getDetail()
    }
    
    override func bindData() {
        viewModel.moviePublishRelay.subscribe{ movieRO in
            self.lblMovieTitle.text = movieRO?.originalTitle
        
            if let backdropPath = movieRO?.backdropPath {
                self.ivMoviePhoto.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)"))
            }
            
            self.lblReleaseDate.text = movieRO?.releaseDate
            self.lblVoteAverage.text = "Rating: \(movieRO?.voteAverage ?? 0.0)"
            self.lblOverview.text = movieRO?.overview
            
            self.setupfavoriteButton(isFavorite: movieRO?.isFavorite ?? false)
            
        
        }.disposed(by: disposeBag)
    }
    
    func setupfavoriteButton(isFavorite: Bool) {
        favoriteButton =  UIBarButtonItem(image: UIImage(systemName: isFavorite ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(onTapFavorite))
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func onTapFavorite() {
        viewModel.updateFavorite()
    }

}
