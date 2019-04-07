//
//  DecodingOperation.swift
//  AppStore
//
//  Created by Mitul Manish on 5/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

protocol DecodableOperationType: class {
    associatedtype DataType: Decodable
    associatedtype Provider: DecodingDataProvider
}

class DecodingOperation<Element, DataProvider>: BasicOperation, DecodableOperationType
where Element: Decodable, DataProvider: DecodingDataProvider {
    
    typealias Provider = DataProvider
    typealias DataType = Element
    
    private(set) var result: Result<DataType, Error>?
    
    private var dataProvider: Provider? {
        return dependencies.first { $0 is Provider } as? Provider
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func main() {
        guard let dataToDecode = dataProvider?.data else {
            result = .failure(dataProvider?.error ?? NetworkError.unknown)
            setFinished()
            return
        }
        do {
            let decodedObject = try JSONDecoder().decode(DataType.self, from: dataToDecode)
            result = .success(decodedObject)
            setFinished()
        } catch {
            result = .failure(error)
            setFinished()
        }
    }
}
