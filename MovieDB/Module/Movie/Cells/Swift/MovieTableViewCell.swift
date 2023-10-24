//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit

protocol MovieTableViewDelegate: AnyObject {
    func updateFavorite(movieRO: MovieRO)
    func selectMovie(movieRO: MovieRO)
}

class MovieTableViewCell: BaseTableViewCell, MovieFavoriteDelegate {

    @IBOutlet weak var lblMovieType: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    weak var delegate: MovieTableViewDelegate?
    
    var type: MovieType = .upcoming
    
    var movies: [MovieRO]? {
        didSet {
            if let _ = movies {
                collectionViewMovies.reloadData()
            }
        }
    }
    
    var title: String? {
        didSet {
            lblMovieType.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func setupUI() {
        super.setupUI()
        
        registerCells()
    }
    
    func registerCells() {
        
        collectionViewMovies.registerForCells(cells: MovieCollectionViewCell.self)
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        
    }
    
    func updateFavorite(movieRO: MovieRO) {
        delegate?.updateFavorite(movieRO: movieRO)
    }
    
    
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movie = movies?[indexPath.item] {
        let cell = collectionView.dequeReuseCell(type: MovieCollectionViewCell.self, indexPath: indexPath)

            cell.delegate = self
            cell.movieRO = movie
            return cell
        } else {
            return UICollectionViewCell()
        }
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = movies else { return }
        delegate?.selectMovie(movieRO: movies[indexPath.item])
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
    
    
}
