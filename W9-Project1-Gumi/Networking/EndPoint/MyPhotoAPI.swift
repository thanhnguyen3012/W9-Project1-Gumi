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
        "https://api.unsplash.com/"
//        "https://api.unsplash.com/photos/?client_id=X8UfN6XkWcMtjfp9RbMJnZJIAylr6K61Elq39hOLeZs&per_page=5&order_by=popular&page=1"
    }
    
    var path: String {
        switch self {
        case .getListPhotos:
            return "photos/"
//        return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListPhotos:
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
//        return URL(string: "\(self.baseURL)\(self.path)client_id=\(KEY) ---- điền params chổ này")
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getListPhotos:
//            return JSONEncoding.default
            return URLEncoding.default
        }
    }
}

