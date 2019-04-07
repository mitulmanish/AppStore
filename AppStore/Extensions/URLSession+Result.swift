//
//  URLSession+Result.swift
//  AppStore
//
//  Created by Mitul Manish on 5/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

public typealias URLSessionNetworkResult = Result<Data, Error>

enum NetworkError: Error {
    case serverError(errorCode: Int)
    case invalidResponseType
    case unknown
}

extension URLSession {
    fileprivate func getResult(data: Data?, response: URLResponse?, error: Error?) -> URLSessionNetworkResult {
        let validStatusCodeRange: ClosedRange<Int> = 200...299
        switch (data, response, error) {
        case let (_, _, error?):
            return .failure(error)
        case let(data?, response as HTTPURLResponse, _) where validStatusCodeRange.contains(response.statusCode):
            return .success(data)
        case let (_, response as HTTPURLResponse, .none):
            return .failure(NetworkError.serverError(errorCode: response.statusCode))
        case (_, _, .none):
            return .failure(NetworkError.invalidResponseType)
        }
    }
    
    func getData(request: URLRequest, dataResponse: @escaping (URLSessionNetworkResult) -> ()) {
        dataTask(with: request) { [unowned self] data, response, error in
            dataResponse(
                self.getResult(data: data, response: response, error: error)
            )
        }
    }
    
    func getData(url: URL, dataResponse: @escaping (URLSessionNetworkResult) -> ()) {
        dataTask(with: url) { [unowned self] data, response, error in
            dataResponse(
                self.getResult(data: data, response: response, error: error)
            )
        }
    }
}
