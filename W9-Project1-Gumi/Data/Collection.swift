//
//  Collection.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 13/05/2021.
//

import Foundation

class Collection: Codable {
    let id: String?
    let title: String?
    let totalPhotos: Int?
    let coverPhoto: MyPhoto?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case totalPhotos = "total_photos"
        case coverPhoto = "cover_photo"
    }
}
