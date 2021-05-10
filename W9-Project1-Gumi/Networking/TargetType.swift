//
//  File.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}
