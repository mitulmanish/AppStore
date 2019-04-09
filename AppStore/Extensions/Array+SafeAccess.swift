//
//  Array+SafeAccess.swift
//  AppStore
//
//  Created by Mitul Manish on 31/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

extension Array {
    enum AccessError: Error {
        case outOfBounds
    }
    
    func getElementAt(index: Int) -> Result<Element, Error> {
        guard (startIndex..<endIndex).contains(index) else {
            return .failure(AccessError.outOfBounds)
        }
        return .success(self[index])
    }
}
