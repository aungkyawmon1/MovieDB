//
//  Data+Extension.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation

extension Data {
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
    
 
}
