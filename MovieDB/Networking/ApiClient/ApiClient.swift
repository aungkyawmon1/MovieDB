//
//  ApiClient.swift
//
//  Created by solinx on 07/08/2023.
//

import Foundation
import Alamofire
import RxRelay
import RxSwift
import RxCocoa

enum ErrorType : Error {
    case unknownError
    case clientError(errorMessage: ErrorMessageResponse)
}

class APIClient {
    static let shared = APIClient()
    let successRange = 199...300
    private let APIManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration, delegate: delegate)
        return manager
    }()
    
    public func request<T>(url: String,
                                  method: HTTPMethod = .get,
                                  parameters: Parameters = [:],
                                  headers: HTTPHeaders = [:],
                                  model: T.Type
    ) ->  Observable<T?> where T: Decodable {
        var url = url
        if let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = urlString
        }
        
        var headers = headers
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(Constant.apiKey)"
        
        let encoding : ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding.default )
        
        return Observable.create { observer in
            self.APIManager.request(url, method: method, parameters: parameters,encoding: encoding, headers: headers).validate().responseDecodable(of: model.self) { (response) in
    
            
                switch response.result {
                    
                case .success:
                    if let data = response.data, let status = response.response?.statusCode, self.successRange.contains(status) {
                        
                        debugPrint("success")
                        observer.onNext(data.decode(modelType: model.self))
                        observer.onCompleted()
                                   
                    }
                case .failure:
                    if let data = response.data, let responseJSON = data.decode(modelType: ErrorMessageResponse.self) {
                        
                        let error = ErrorType.clientError(errorMessage: responseJSON)
                        observer.onError(error)
                    }else{
                        let error = ErrorType.unknownError
                        observer.onError(error)
                    }
                    
                }
            }
            return Disposables.create()
            
        }
    }
}
