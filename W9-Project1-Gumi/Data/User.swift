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
    let profileImageUrl: ProfileImageUrls?
    
    enum UserCodingKeys: String, CodingKey {
        case id
        case name
        case profileImageUrl = "profile_image"
    }
}

class ProfileImageUrls: Codable {
    let small: String?
    let medium: String?
    let large: String?
}
