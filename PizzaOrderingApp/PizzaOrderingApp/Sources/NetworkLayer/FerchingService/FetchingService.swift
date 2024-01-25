//
//  FetchingService.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.

import Foundation


protocol FetchingServiceProtocol : AnyObject {
    func getData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

final class FetchingService : FetchingServiceProtocol {
    
    private var parser: Parsing = Parser()
    
    func getData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? NSError, error.code == NSURLErrorSecureConnectionFailed {
                print("SSL Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
        guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
            
            self.parser.decodeJSON(ofType: T.self, from: data, completion: completion)
        }
        
        task.resume()
    }
}
