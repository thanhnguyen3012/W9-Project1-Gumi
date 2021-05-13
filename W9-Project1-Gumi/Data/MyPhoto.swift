//
//  MyPhoto.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import UIKit

class MyPhoto: Codable {
    var id: String?
    var urls: MyPhotosURLs?
    var user: User?
    var description: String?
    var altDescription: String?
    var width: Int?
    var height: Int?
    var categories : [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
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
    var raw: String?
    var thumbnail: String?
    
    enum  CodingKeys: String, CodingKey {
        case raw
        case thumbnail = "thumb"
    }
}

