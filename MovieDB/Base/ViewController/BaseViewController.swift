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
    
    var loadingBackgroundView: UIView?
    var activityIndicator: UIActivityIndicatorView?
    
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
    
    // MARK: - Error Alert
    func showAlert(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Loading
    func showLoading() {
        self.hideLoading()
        
        loadingBackgroundView = UIView(frame: .zero)
        loadingBackgroundView?.backgroundColor = .white.withAlphaComponent(0.7)
        self.view.addSubview(loadingBackgroundView!)
        
        loadingBackgroundView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingBackgroundView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingBackgroundView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingBackgroundView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingBackgroundView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator?.startAnimating()
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            activityIndicator!.widthAnchor.constraint(equalToConstant: 42.0),
            activityIndicator!.heightAnchor.constraint(equalToConstant: 42.0)
        ])
        
        
    }
    
    func hideLoading() {
        
        if let activityIndicator = activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        if let loadingBackgroundView = loadingBackgroundView {
            loadingBackgroundView.removeFromSuperview()
        }
    }

}
