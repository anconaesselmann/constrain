//  Created by Axel Ancona Esselmann on 5/5/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public enum ConstraintIdentifier: String {
    case top = ".top"
    case leading = ".leading"
    case trailing = ".trailing"
    case bottom = ".bottom"
    case topSafe = ".topSafe"
    case bottomSafe = ".bottomSafe"
    case height = ".height"
    case width = ".width"
    case centerX = ".centerX"
    case centerY = ".centerY"
    case aspectRatio = ".aspectRatio"
}

public enum Relationship {
    case equal
    case lessThanOrEqual
    case greaterThanOrEqual
}

public typealias ConstraintSet = [NSLayoutConstraint]

/// Constraints is a container of layout constraints for a UIView. It has convenience methods for creating and retrieving constraints.
/// For improved readability constraint-creation methods can be chained.
/// Constraints are active on creation
/// Most methods allow the omission of an anchor or view to be passed in.
/// The superview is used when no view is passed in and the superview's respective anchor is used when the anchor is omitted.
public class Constraints {

    internal weak var view: UIView?
    internal var viewName: String
    private var constraints: [ConstraintIdentifier: NSLayoutConstraint] = [:]
    
    public var latestConstraint: NSLayoutConstraint?
    public var latestConstraints: ConstraintSet?

    internal init(view: UIView, name: String? = nil) {
        self.view = view
        self.viewName = name ?? String.init(describing: view.self)
    }

    /// When storing a reference to a Constraints instance this method allows to retrieve a respective constraint.
    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }

    /// When storing a reference to a Constraints instance this method allows to set the constant of a respective constraint.
    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }

    internal func applyAnchorConstraint<T>(anchor1: NSLayoutAnchor<T>,
                                           anchor2: NSLayoutAnchor<T>,
                                           identifier: ConstraintIdentifier,
                                           constant: CGFloat,
                                           relationship: Relationship = .equal,
                                           priority: UILayoutPriority) -> Constraints {
        let constraint: NSLayoutConstraint
        switch relationship {
        case .equal: constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
        case .lessThanOrEqual: constraint = anchor1.constraint(lessThanOrEqualTo: anchor2, constant: constant)
        case .greaterThanOrEqual: constraint = anchor1.constraint(greaterThanOrEqualTo: anchor2, constant: constant)
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
        case .equal: constraint = dimension.constraint(equalToConstant: constant)
        case .lessThanOrEqual: constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual: constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        }
        constraint.priority = priority
        finalizeConstraint(constraint, identifier)
        return self
    }
    
    internal func applyDimensionMultiplierConstraint(
        dimension1: NSLayoutDimension,
        dimension2: NSLayoutDimension,
        identifier: ConstraintIdentifier,
        constant: CGFloat,
        multiplier: CGFloat = 1,
        relationship: Relationship = .equal,
        priority: UILayoutPriority
    ) -> Constraints {
        let constraint: NSLayoutConstraint
        switch relationship {
        case .equal: constraint = dimension1.constraint(equalToConstant: constant)
        case .lessThanOrEqual: constraint = dimension1.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual: constraint = dimension1.constraint(greaterThanOrEqualToConstant: constant)
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
        constraint.isActive = true
        let identifier = ConstraintIdentifier.aspectRatio
        constraint.identifier = viewName + identifier.rawValue
        constraints[identifier] = constraint // TODO: deactivate any existing before overwriting, or allow more than one of same identifier
        latestConstraint = constraint
    }

}
