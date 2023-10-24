//
//  BaseCollectionViewCell.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindData()
        setupUI()
    }
    
    func bindData() {
        
    }
    
    func setupUI() {
       
    }
    
}
