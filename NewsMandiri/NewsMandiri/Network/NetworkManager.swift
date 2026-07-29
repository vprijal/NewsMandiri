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
        
    /// Request using Swift Concurrency (async/await)
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
    
    /// Request using Completion Handler
    func request<T: Codable>(route: NetworkRouter, completion: @escaping (Swift.Result<T?, Error>) -> Void) {
        do {
            let request = try route.asURLRequest()
            sessionManager.request(request).responseData { response in
                print(response.request?.url?.absoluteString ?? "")
                
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(T.self, from: value)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("\(#line), \(#function), \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        } catch {
            print("\(#line), \(#function), \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
