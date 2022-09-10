//
//  Routing.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation

protocol NetworkRoute {
    func request<T>(completion : @escaping WebResponse<T>)
}

extension NetworkRoute {
    func getRequest(api : UserEndpoints) throws -> URLRequest {
        
        /**
         https://api.themoviedb.org/3/movie/popular?api_key=38a73d59546aa378980a88b645f487fc&page=1
         */
//        guard let url = URL(string: api.baseURL + api.path) else {
//            throw APIErrors.invalidURL
//        }
//
        guard var urlComponents = URLComponents(string: api.baseURL + api.path) else {
            throw APIErrors.invalidURL
        }
        
        if let parameters : [String : String] = api.headers {
            urlComponents.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = urlComponents.url else {
            throw APIErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        if let body = api.body {
            request.httpBody = body
        }
        request.httpMethod = api.method.value
        return request
    }
}

