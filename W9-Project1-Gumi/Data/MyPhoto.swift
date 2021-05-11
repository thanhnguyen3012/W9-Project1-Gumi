//
//  MyPhoto.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class MyPhoto: Codable {
    var urls: MyPhotosURLs?
    var user: User?
    var description: String?
    var altDescription: String?
    var width: Int?
    var height: Int?
    var categories : [String]?
    
    enum MyPhotoCodingKeys: String, CodingKey {
        case urls
        case user
        case description
        case altDescription = "alt_description"
        case width
        case height
        case categories
    }
}

class MyPhotosURLs: Codable {
    var thumbnail: String?
    var raw: String?
    
    enum  URLsCodingKeys: String, CodingKey {
        case thumbnail = "thumb"
        case raw
    }
}

