//
//  BaseTableViewCell.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
        bindData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
    }
    
    func bindData() {
        
    }

}
