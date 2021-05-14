//
//  SearchResults.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import Foundation

class SearchResults<T: Codable>: Codable {
    let amount: Int?
    let results: [T]?
    
    enum CodingKeys: String, CodingKey {
        case amount = "total"
        case results
    }
}
