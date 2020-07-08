//
//  NetworkService.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation
import XMLParsing

class NetworkService {
    
    func getData<T: Codable>(url: String, completionHandler:
        @escaping (Result<T, NetworkErrorService>) -> ()) {
        
        guard let url = URL(string: url) else { completionHandler(.failure(.badURL))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response else {
                completionHandler(.failure(.noResponse))
                return }
            guard let data = data else {
                completionHandler(.failure(.noData))
                return }
            if error != nil {
                completionHandler(.failure(.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.badResponse))
                return
            }

            do {
                let gistList = try XMLDecoder().decode(T.self, from: data)
                completionHandler(.success(gistList))
            } catch {
                completionHandler(.failure(.xmlDecoding))
            }

        }.resume()
    }
}
