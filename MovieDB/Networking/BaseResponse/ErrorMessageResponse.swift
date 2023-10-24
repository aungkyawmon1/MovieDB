//
//  ErrorMessageResponse.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation

struct ErrorMessageResponse: Codable {
    let status : Int?
    let message : String?
    
    enum CodingKeys : String , CodingKey {
        case status
        case message
    }
}
