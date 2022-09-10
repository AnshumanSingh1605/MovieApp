//
//  Endpoints.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation

typealias WebResponse<ValidServerResponse> = (Result<ValidServerResponse, APIErrors>) -> Void where ValidServerResponse : Codable


protocol Endpoints : NetworkRoute {
    var path : String { get }
    var method : HTTPMethod { get }
    var headers : [String : String]? { get }
    var body : Data? { get }
}

extension Endpoints {
    var baseURL : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var apiKey : String {
        return "38a73d59546aa378980a88b645f487fc"
    }
}


