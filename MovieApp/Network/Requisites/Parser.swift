//
//  NetworkInterface.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation

protocol Parsable {
    func parseResponse<T>(data : Data) throws -> T where T : Decodable
}
