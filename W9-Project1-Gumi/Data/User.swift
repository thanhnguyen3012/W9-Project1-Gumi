//
//  User.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import Foundation

// This class represent for Unsplash user
class User: Codable {
    let id: String?
    let name: String?
    
    enum UserCodingKeys: String, CodingKey {
        case id
        case name
    }
}
