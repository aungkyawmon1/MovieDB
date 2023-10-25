//
//  BaseViewModel.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel {
    let disposeBag = DisposeBag()
    var viewController : BaseViewController?
    
    let loadingPublishRelay = PublishRelay<Bool>()
    
    let errorPublishRelay = PublishRelay<String>()
    
    func bindViewModel(in viewController: BaseViewController? = nil ) {
        self.viewController = viewController
        
        loadingPublishRelay.bind {
            debugPrint("Loading")
            if $0 {
                viewController?.showLoading()
            } else {
                viewController?.hideLoading()
            }
        }.disposed(by: disposeBag)
        
        
        errorPublishRelay.bind {
            viewController?.showAlert(title: "Info", message: $0)
        }.disposed(by: disposeBag)
    }
}
