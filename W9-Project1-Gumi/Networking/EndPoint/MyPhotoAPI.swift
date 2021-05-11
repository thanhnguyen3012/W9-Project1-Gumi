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
}

// MARK: - MyPhotoAPI
extension MyPhotoAPI: TargetType {
    var baseURL: String {
//        "https://api.unsplash.com/"
    }
    
    var path: String {
        switch self {
        case .getListPhotos:
            return "photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListPhotos:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListPhotos:
            return JSONEncoding.default
        }
    }
}

