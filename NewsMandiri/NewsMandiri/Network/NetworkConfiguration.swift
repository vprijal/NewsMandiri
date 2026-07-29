//
//  NetworkConfiguration.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//
import Foundation
import Alamofire

protocol NetworkConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}
