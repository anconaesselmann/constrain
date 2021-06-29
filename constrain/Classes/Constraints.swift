//  Created by Axel Ancona Esselmann on 5/5/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public typealias Relationship = NSLayoutConstraint.Relation

/// Constraints is a container of layout constraints for a UIView. It has convenience methods for creating and retrieving constraints.
/// For improved readability, all methods can be chained.
/// Constraints are active on creation
/// Most methods allow the omission of an anchor or view to be passed in.
/// The superview is used when no view is passed in and the superview's respective anchor is used when the anchor is omitted.
public class Constraints {
    
    internal weak var view: UIView?
    private var viewName: String?
    internal var constraints: [ConstraintIdentifier: NSLayoutConstraint] = [:]
    internal var allConstraints: [NSLayoutConstraint] = []
    internal var isActive = true
    
    public var latestConstraint: NSLayoutConstraint?
    
    internal init(view: UIView, name: String? = nil) {
        self.view = view
        self.viewName = name
    }
    
    func identifier(for `case`: ConstraintIdentifier) -> String {
        if let viewName = viewName {
            return viewName + "." + `case`.rawValue
        } else {
            return `case`.rawValue
        }
    }
    
}

public extension UIView {
    /// Returns a Constraint instance which eases creation of NSLayoutConstraints.
    /// Save a reference to the Constraint instance for later access to the layout constraints.
    var constrain: Constraints {
        return Constraints(view: self)
    }
    
    func constrain(withName name: String) -> Constraints {
        return Constraints(view: self, name: name)
    }
}

extension Constraints {
    
    internal func applyAnchorConstraint<T>(
        anchor1: NSLayoutAnchor<T>,
        anchor2: NSLayoutAnchor<T>,
        identifier: ConstraintIdentifier,
        constant: CGFloat,
        relationship: Relationship = .equal,
        priority: UILayoutPriority
    ) -> Constraints {
        let constraint: NSLayoutConstraint
        switch relationship {
        case .lessThanOrEqual: constraint = anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        case .greaterThanOrEqual: constraint = anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
        default: constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
        }
        constraint.priority = priority
        finalizeConstraint(constraint, identifier)
        return self
    }
    
    internal func applyDimensionConstraint(
        dimension: NSLayoutDimension,
        identifier: ConstraintIdentifier,
        constant: CGFloat,
        relationship: Relationship = .equal,
        priority: UILayoutPriority
    ) -> Constraints {
        let constraint: NSLayoutConstraint
        switch relationship {
        case .lessThanOrEqual: constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual: constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        default: constraint = dimension.constraint(equalToConstant: constant)
        }
        constraint.priority = priority
        finalizeConstraint(constraint, identifier)
        return self
    }
    
    internal func applyDimensionMultiplier(
        dimension1: NSLayoutDimension,
        dimension2: NSLayoutDimension,
        identifier: ConstraintIdentifier,
        constant: CGFloat,
        multiplier: CGFloat = 1,
        relationship: Relationship = .equal,
        priority: UILayoutPriority
    ) -> Constraints {
        guard multiplier.isFinite else {
            print("Attempting to set a non-finite multiplier.")
            return self
        }
        let constraint: NSLayoutConstraint
        switch relationship {
        case .lessThanOrEqual: constraint = dimension1.constraint(lessThanOrEqualTo: dimension2, multiplier: multiplier)
        case .greaterThanOrEqual: constraint = dimension1.constraint(greaterThanOrEqualTo: dimension2, multiplier: multiplier)
        default: constraint = dimension1.constraint(equalTo: dimension2, multiplier: multiplier)
        }
        // for some reason anchor constraint initializers can either take multiplier or constant but not both
        // multiplier is immutable, so I'm just setting constant after initializing
        constraint.constant = constant
        constraint.priority = priority
        finalizeConstraint(constraint, identifier)
        return self
    }
    
    fileprivate func finalizeConstraint(_ constraint: NSLayoutConstraint, _ identifier: ConstraintIdentifier) {
        view?.translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = isActive
        constraint.identifier = self.identifier(for: identifier)
        constraints[identifier] = constraint
        allConstraints.append(constraint)
        latestConstraint = constraint
    }
}
