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
    
    static var isInternetConnected: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func call<T>(type: TargetType, completionHandler: @escaping (_ result: Result<[T]?, ResponseError>)-> ()) where T: Codable {
        
        //Check internet connection
        if APIManager.isInternetConnected == false {
            let error = ResponseError()
            error.errors = ["No internet connection."]
            completionHandler(.failure(error))
            return
        }
        
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: type.parameters,
                   encoding: type.encoding,
                   headers: type.headers,
                   requestModifier: { $0.timeoutInterval = 30 })
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
                case .failure(let er):
                    let error = ResponseError()
                    print("Errrrrr \(er)")
                    error.errors = er.isSessionTaskError ? [er.localizedDescription] : [self.handleErrorCode(er.responseCode ?? 0)]
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
    func call<T>(type: TargetType, completionHandler: @escaping (_ result: Result<T?, ResponseError>)-> ()) where T: Codable {
        
        //Check internet connection
        if APIManager.isInternetConnected == false {
            let error = ResponseError()
            error.errors = ["No internet connection."]
            completionHandler(.failure(error))
            return
        }
        
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: type.parameters,
                   encoding: type.encoding,
                   headers: type.headers,
                   requestModifier: { $0.timeoutInterval = 30 })
            .validate()
            .responseJSON { data in
                switch data.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        print(data)
                        let result = try! decoder.decode(T.self, from: jsonData)
                        completionHandler(.success(result))
                    }
                case .failure(let er):
                    let error = ResponseError()
                    print("Errrrrr \(er)")
                    error.errors = er.isSessionTaskError ? [er.localizedDescription] : [self.handleErrorCode(er.responseCode ?? 0)]
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
    private func handleErrorCode(_ errorCode: Int) -> String {
        switch errorCode {
        case 400:
            return "The request was unacceptable, often due to missing a required parameter."
        case 401:
            return "Invalid Access Token."
        case 403:
            return "Missing permissions to perform request."
        case 404:
            return "The requested resource doesn’t exist."
        case 500, 503:
            return "Something went wrong on our end."
        case -1001:
            return "Request timeout."
        default:
            return ""
        }
    }
    
    static func createErrorAlert(error: ResponseError) -> UIAlertController {
        var err = ""
        for e in error.errors ?? [] {
            err = err + e + "\n"
        }
        let alert = UIAlertController(title: "Error", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
}
