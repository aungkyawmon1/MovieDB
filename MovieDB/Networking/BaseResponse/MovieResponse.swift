//
//  MovieResponse.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation

// MARK: - Welcome
struct MovieResponse: Codable {
    let page: Int?
    let results: [MovieVO]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DatesValue: Codable {
    let maximum, minimum: String?
    
    enum CodingKeys: String, CodingKey {
        case maximum, minimum
    }
}
