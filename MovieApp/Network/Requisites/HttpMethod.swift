//
//  HttpMethods.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation

enum HTTPMethod : String {
    
    case get
    
    var value : String {
        return rawValue.uppercased()
    }
}
