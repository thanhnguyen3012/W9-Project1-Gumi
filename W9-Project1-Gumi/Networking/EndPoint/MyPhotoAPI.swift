//
//  MyPhotoAPI.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import Foundation
import Alamofire

enum MyPhotoAPI {
    case getListPhotos(page: Int, perPage: Int)
    case getListTopics
    case getPhotosOfTopic(id: String)
    case searchPhotos
    case searchCollections
    case searchUsers
}

// MARK: - MyPhotoAPI
extension MyPhotoAPI: TargetType {
    var baseURL: String {
        "https://api.unsplash.com/"
    }
    
    var path: String {
        switch self {
        case .getListPhotos:
            return "photos/"
        case .getListTopics:
            return "topics"
        case .getPhotosOfTopic(let id):
            return "/topics/\(String(describing: id))/photos"
        case .searchPhotos:
            return "/search/photos/"
        case .searchCollections:
            return "/search/collections/"
        case .searchUsers:
            return "/search/users/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListPhotos, .getListTopics, .getPhotosOfTopic, .searchPhotos, .searchCollections, .searchUsers:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
//        return ["Content-Type": "application/json"]
        return nil
    }
    
    var url: URL {
        let plist = NSDictionary(contentsOfFile: "/Users/admin/Desktop/Gumi/W9-Project1-Gumi/W9-Project1-Gumi/Keys.plist")
        let key = plist?.object(forKey: "API_KEY") as! String
        return URL(string: self.baseURL + self.path + "?client_id=" + key)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListPhotos, .getListTopics, .getPhotosOfTopic, .searchPhotos, .searchCollections, .searchUsers:
            return URLEncoding.default
        }
    }
}

