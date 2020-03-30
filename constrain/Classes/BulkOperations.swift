//
//  BulkOperations.swift
//  constrain
//
//  Created by New Greg on 3/25/20.
//

import Foundation

// bulk activation/deactivation
public extension Constraints {
    
    @discardableResult
    func activate() -> Self {
        NSLayoutConstraint.activate(allConstraints)
        isActive = true
        return self
    }
    
    @discardableResult
    func deactivate() -> Self {
        NSLayoutConstraint.deactivate(allConstraints)
        isActive = false
        return self
    }
    
    @discardableResult
    func toggle() -> Self {
        return isActive ? deactivate() : activate()
    }
    
    @discardableResult
    func clearSet() -> Self {
        deactivate() // this also removes them from the view
        allConstraints = []
        constraints = [:]
        isActive = true
        return self
    }
    
}
