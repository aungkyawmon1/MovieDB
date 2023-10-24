//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit
import Kingfisher

protocol MovieFavoriteDelegate: AnyObject {
    func updateFavorite(movieRO: MovieRO)
}

class MovieCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var ivFavorite: UIImageView!
    
    weak var delegate: MovieFavoriteDelegate?
    
    private var movieID: Int?
    
    var movieRO: MovieRO? {
        didSet {
            if let movieRO = movieRO {
                lblMovieTitle.text = movieRO.title
                movieID = movieRO.id
                if let moviePoster = movieRO.posterPath {
                    ivMoviePoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(moviePoster)"))
                }
                
                ivFavorite.image = UIImage(systemName: movieRO.isFavorite ?? false ? "heart.fill" : "heart" )
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setupUI() {
        super.setupUI()
        
        addGuesture()
        
    }
    
    private func addGuesture() {
        
        let tapFavoriteGesture = UITapGestureRecognizer(target: self, action: #selector(onTapFavorite) )
        ivFavorite.addGestureRecognizer(tapFavoriteGesture)
        ivFavorite.isUserInteractionEnabled = true
    }
    
    @objc func onTapFavorite() {
        debugPrint("Tap")
        guard let movieRO = movieRO else { return }
        
        delegate?.updateFavorite(movieRO: movieRO)
    }

}
