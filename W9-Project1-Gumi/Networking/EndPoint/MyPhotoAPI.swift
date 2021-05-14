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
    case searchPhotos(query: String)
    case searchCollections(query: String)
    case searchUsers(query: String)
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
    
    var parameters: Parameters? {
        switch self {
        case .getListPhotos(let page, let perPage):
            return ["page": page, "per_page": perPage]
        case .searchPhotos(let query), .searchCollections(let query), .searchUsers(let query):
            return ["query": query]
        default:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        let plist = NSDictionary(contentsOfFile: "/Users/admin/Desktop/Gumi/W9-Project1-Gumi/W9-Project1-Gumi/Keys.plist")
        let key = plist?.object(forKey: "API_KEY") as! String
        return ["Authorization": "Client-ID \(key)",
                "Content-Type" : "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListPhotos, .getListTopics, .getPhotosOfTopic, .searchPhotos, .searchCollections, .searchUsers:
            return URLEncoding.default
        }
    }
}

