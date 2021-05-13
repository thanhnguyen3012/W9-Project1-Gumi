//
//  Topic.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 12/05/2021.
//

import Foundation

class Topic: Codable {
    let id: String?
    let title: String?
    let totalPhotos: Int?
    let owners: [User]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case totalPhotos = "total_photos"
        case owners
    }
}
