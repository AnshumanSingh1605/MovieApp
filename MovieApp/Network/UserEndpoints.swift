//
//  UserEndoints.swift
//  MovieApp
//
//  Created by Anshuman Singh on 10/09/22.
//

import Foundation
import UIKit

enum UserEndpoints : Endpoints {
    
    case movies(Int)
    
    var path: String {
        switch self {
        case .movies:       return "movie/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .movies:       return .get
        }
    }
    
    var headers: [String : String]? {
        var header = ["api_key" : apiKey]
        switch self {
        case .movies(let page) :
            header["page"] = "\(page)"
        }
        return header
    }
    
    var body: Data? {
        return nil
    }
}

extension UserEndpoints : Parsable {
    
    
    func request<T>(completion: @escaping WebResponse<T>) where T : Codable {
        do {
            let request = try getRequest(api: self)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                // Check the response
                debugPrint(response as Any)
                
                // Check if an error occured
                if let error = error {
                    // HERE you can manage the error
                    print(error)
                    completion(.failure(.custom(error.localizedDescription)))
                    return
                }
                
                guard let responseData = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                debugPrint(String(data: responseData, encoding: .utf8))
                
                do {
                    let response : T = try parseResponse(data: responseData)
                    completion(.success(response))
                }
                catch APIErrors.invalidData {
                    completion(.failure(.invalidData))
                }
                catch let error {
                    completion(.failure(.custom(error.localizedDescription)))
                }
            })
            task.resume()
            
        } catch APIErrors.invalidURL {
            completion(.failure(.invalidURL))
        } catch let error {
            completion(.failure(.custom(error.localizedDescription)))
        }
    }
    
    func parseResponse<T>(data: Data) throws -> T where T : Decodable {
        // Serialize the data into an object
        do {
            let model = try JSONDecoder().decode(T.self, from: data )
            print(model)
            return model
        }
        catch {
            throw APIErrors.invalidData
        }
        catch let error {
            throw APIErrors.custom(error.localizedDescription)
        }
    }
}
