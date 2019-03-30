//
//  Service.swift
//  AppStore
//
//  Created by Mitul Manish on 30/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//
import Foundation

enum ServiceError: Error {
    case noData
    case inValidResponse
}

class Service {
    static let shared = Service()
    
    func fetchApps(url: URL, completion: @escaping ([SearchResultItem]?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(.none, err)
            }
            
            let validStatusCodeRange: ClosedRange<Int> = 200...299
            guard let httpResponse = response as? HTTPURLResponse, validStatusCodeRange.contains(httpResponse.statusCode) else {
                completion(.none, ServiceError.inValidResponse)
                return
            }
            
            guard let data = data else {
                completion(.none, ServiceError.noData)
                return
            }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, .none)
            } catch {
                completion(.none, error)
            }
        }.resume()
    }
}
