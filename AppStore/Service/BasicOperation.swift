//
//  BasicOperation.swift
//  AppStore
//
//  Created by Mitul Manish on 6/4/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import Foundation

class BasicOperation: Operation {
    
    private enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    func setExecuting() {
        state = .executing
    }
    
    func setFinished() {
        state = .finished
    }
    
    override func start() {
        if isCancelled {
            setFinished()
            return
        }
        main()
        setExecuting()
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
