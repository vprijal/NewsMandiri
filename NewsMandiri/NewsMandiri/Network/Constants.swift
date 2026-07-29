//
//  Constants.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

import Foundation
import Alamofire

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://newsapi.org/v2"
        static let apiKey = "4a27365f23b24d8eb502b59016e31f07"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content_Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
}

enum ContentType: String {
    case json = "Application/json"
    case formEncode = "application/x-ww-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}
