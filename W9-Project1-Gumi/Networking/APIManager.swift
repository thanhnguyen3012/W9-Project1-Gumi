//
//  APIManager.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import Foundation
import Alamofire

class APIManager {
    static var shared = APIManager()
    
    private init() { }
    
    func call<T>(type: TargetType, params: Parameters?, completionHandler: @escaping (_ result: Result<[T]?, ResponseError>)-> ()) where T: Codable {
        print("Test url request: \(type.url)")
        let p : Parameters = ["page": "1", "per_page": "3"]
        print("=== \(p)")
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: p,//params,
                   encoding: type.encoding,
                   headers: type.headers)
            .validate()
            .responseJSON { data in
                switch data.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        print(data)
                        let result = try! decoder.decode([T].self, from: jsonData)
                        completionHandler(.success(result))
                    }
                case .failure(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data, let error = try? decoder.decode(ResponseError.self, from: jsonData) {
                        completionHandler(.failure(error))
                    }
                    break
                }
            }
    }
}
