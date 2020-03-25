//
//  BulkOperations.swift
//  constrain
//
//  Created by New Greg on 3/25/20.
//

import Foundation

public typealias ConstraintSet = [NSLayoutConstraint]

// bulk activation/deactivation
extension Constraints {
    
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(allConstraints)
        isActive = true
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(allConstraints)
        isActive = false
        return self
    }
    
    @discardableResult
    public func toggle() -> Self {
        return isActive ? deactivate() : activate()
    }
    
}
