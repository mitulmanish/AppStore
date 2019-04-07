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
    case invalidURL
    case invalidSearchTerm
}

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([SearchResultItem]?, Error?) -> ()) {
        guard let finalSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return completion(.none, ServiceError.invalidSearchTerm)
        }
        let urlString = "https://itunes.apple.com/search?term=\(finalSearchTerm)&entity=software"
        guard let url = URL(string: urlString) else {
            completion(.none, ServiceError.invalidURL)
            return
        }
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
    
    func fetchGames<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.none, ServiceError.invalidURL)
            return
        }
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
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, .none)
            } catch {
                completion(.none, error)
            }
            }.resume()
    }
}
