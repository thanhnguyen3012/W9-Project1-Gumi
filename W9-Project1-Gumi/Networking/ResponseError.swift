//
//  ResponseError.swift
//  W9-Project1-Gumi
//
//  Created by Thành Nguyên on 10/05/2021.
//

import Foundation

class ResponseError: Codable, Error {
    var key: String?
    var errors: [String]?
}
