//
//  NetworkOperation.swift
//  AppStore
//
//  Created by Mitul Manish on 6/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

protocol DecodingDataProvider: class {
    var data: Data? { get }
    var error: Error? { get }
}

class NetworkOperation: BasicOperation {
    private let session: URLSession
    private let urlRequest: URLRequest
    
    private (set) var networkResult: URLSessionNetworkResult?
    
    override var isAsynchronous: Bool {
        return true
    }
    
    init(urlRequest: URLRequest, session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        self.urlRequest = urlRequest
    }
    
    override func main() {
        session.getData(request: urlRequest) { [weak self] result in
            self?.networkResult = result
            self?.setFinished()
        }
    }
}

extension NetworkOperation: DecodingDataProvider {
    var data: Data? {
        guard let result = networkResult, case let .success(data) = result else {
            return .none
        }
        return data
    }
    
    var error: Error? {
        guard let result = networkResult, case let .failure(error) = result else {
            return .none
        }
        return error
    }
}
