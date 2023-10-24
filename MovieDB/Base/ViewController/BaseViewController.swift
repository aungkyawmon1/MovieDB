//
//  BaseViewController.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import UIKit
import RxSwift


class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private var alert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        registerCell()
        
        setupUI()
        
        bindViewModel()
        
        bindData()
        
    }
    
    func setupUI() {
        
    }
    
    func bindData() {
        
    }
    
    func registerCell() {
        
    }
    
    func bindViewModel() {
        
    }
    
    // MARK: - Loading
    func showLoading() {
        alert = UIAlertController(title: nil, message: "အချက်အလက်များရယူနေပါသည် ခေတ္တစောင့်ပေးပါ", preferredStyle: .alert)

        guard let alert = alert else { return }
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        guard let _ = alert else { return }
        dismiss(animated: true)
    }

}
