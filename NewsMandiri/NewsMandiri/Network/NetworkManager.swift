//
//  NetworkManager.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//


import Foundation
import Alamofire

class NetworkManager {
    
    typealias NetworkCompletion<T> = (Result<T, Error>) -> Void
    
    private var dataRequest: DataRequest?
    let sessionManager: Session
    static let shared: NetworkManager = NetworkManager()
    
    init() {
        sessionManager = Session()
    }
    
    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) -> DataRequest {
        return sessionManager.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
        
    func request<T: Decodable>(route: NetworkRouter) async throws -> T {
        let urlRequest = try route.asURLRequest()
        
        let dataResponse = await sessionManager.request(urlRequest)
            .serializingDecodable(T.self)
            .response
        
        print(dataResponse.request?.url?.absoluteString ?? "")
        
        switch dataResponse.result {
        case .success(let value):
            return value
        case .failure(let error):
            print("\(#line), \(#function), \(error.localizedDescription)")
            throw error
        }
    }
}
