//
//  NetworkRouter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

import Foundation
import Alamofire

enum NetworkRouter: NetworkConfiguration {
    case getSources(category: String)
    case article(id: String, page: Int = 1, pageSize: Int = 20)
    
    var method: HTTPMethod {
        switch self {
        case .getSources, .article:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSources(let category):
            return .url(["category": category, "apiKey": Constants.ProductionServer.apiKey])
        case .article(let id, let page, let pageSize):
            return .url([
                "sources": id,
                "page": page,
                "pageSize": pageSize,
                "apiKey": Constants.ProductionServer.apiKey
            ])
        }
    }
    
    var path: String {
        switch self {
        case .getSources:
            return "/sources"
        case .article:
            return "/top-headlines"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        //Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        //Parameters
        
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            let queryParams = params.map { pair in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
    
}
