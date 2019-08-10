//
//  ImplicitSuperviewShortcuts.swift
//  constrain
//
//  Created by Greg on 8/10/19.
//

import UIKit

// These functions let you omit the "constant: " parameter prefix when your constraining to superview

extension Constraints {
    
    /// Constrain the view to a layout anchor or to the top of the superview when no anchor is provided.
    @discardableResult
    public func top(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return top(constant: constant, by: relationship, priority: priority)
    }
    
    /// Constrain the view to a layout anchor or to the bottom of the superview when no anchor is provided.
    @discardableResult
    public func bottom(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return bottom(constant: constant, by: relationship, priority: priority)
    }
    
    /// Constrain the view to the leading edge of the superview.
    @discardableResult
    public func leading(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return leading(constant: constant, by: relationship, priority: priority)
    }
    
    /// Constrain the view to the trailing edge of the superview.
    @discardableResult
    public func trailing(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return trailing(constant: constant, by: relationship, priority: priority)
    }
    
    /// Fills the width of the superview.
    @discardableResult
    public func fillWidth(_ constant: CGFloat = 0.0) -> Constraints {
        return fillWidth(constant: constant)
    }
    
    /// Fills the height of the superview.
    @discardableResult
    public func fillHeight(_ constant: CGFloat = 0.0) -> Constraints {
        return fillHeight(constant: constant)
    }
}
