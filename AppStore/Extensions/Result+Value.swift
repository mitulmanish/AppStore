//
//  Result+Value.swift
//  AppStore
//
//  Created by Mitul Manish on 9/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

extension Result {
    var value: Success? {
        return try? get()
    }
}
