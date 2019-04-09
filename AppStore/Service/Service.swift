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
    
    func fetchApps<DataType: Decodable>(searchTerm: String, completion: @escaping (Result<DataType, Error>) -> ()) {
        guard let finalSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return completion(.failure(ServiceError.invalidSearchTerm))
        }
        let urlString = "https://itunes.apple.com/search?term=\(finalSearchTerm)&entity=software"
        
        fetch(urlString: urlString) { (result: Result<DataType, Error>) in
            completion(result)
        }
    }
    
    func fetch<DataType: Decodable>(urlString: String, completion: @escaping (Result<DataType, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        URLSession.shared.getData(url: url) { networkResult in
            switch networkResult {
            case let .success(data):
                do {
                    let result = try JSONDecoder().decode(DataType.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
