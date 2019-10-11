//  Created by Axel Ancona Esselmann on 5/5/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public enum ConstraintIdentifier: Hashable {
    
    case top
    case leading
    case trailing
    case bottom
    case topSafe
    case bottomSafe
    case height
    case width
    case centerX
    case centerY
    case aspectRatio
    case named(String)
    
    public var string: String {
        switch self {
        case .top:
            return ".top"
        case .leading:
            return ".leading"
        case .trailing:
            return ".trailing"
        case .bottom:
            return ".bottom"
        case .topSafe:
            return ".topSafe"
        case .bottomSafe:
            return ".bottomSafe"
        case .height:
            return ".height"
        case .width:
            return ".width"
        case .centerX:
            return ".centerX"
        case .centerY:
            return ".centerY"
        case .aspectRatio:
            return ".aspectRatio"
        case .named(let name):
            return ".named(\(name))"
        }
    }
}

public typealias Relationship = NSLayoutConstraint.Relation

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
    // Not implemented yet
    @available(*, unavailable)
    public var latestConstraints: ConstraintSet?
    
    internal init(view: UIView, name: String? = nil) {
        self.view = view
        self.viewName = name ?? String.init(describing: view.self)
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
        identifiers: Set<ConstraintIdentifier>,
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
        finalizeConstraint(constraint, identifiers)
        return self
    }
    
    internal func applyDimensionConstraint(
        dimension: NSLayoutDimension,
        identifiers: Set<ConstraintIdentifier>,
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
        finalizeConstraint(constraint, identifiers)
        return self
    }
    
    internal func applyDimensionMultiplier(
        dimension1: NSLayoutDimension,
        dimension2: NSLayoutDimension,
        identifiers: Set<ConstraintIdentifier>,
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
        finalizeConstraint(constraint, identifiers)
        return self
    }
    
    fileprivate func finalizeConstraint(_ constraint: NSLayoutConstraint, _ identifiers: Set<ConstraintIdentifier>) {
        view?.translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = true
        constraint.identifier = viewName + identifiers.map { $0.string }.joined(separator: "+")
        for identifier in identifiers {
            constraints[identifier] = constraint
        }
        latestConstraint = constraint
    }
    
    /// When storing a reference to a Constraints instance this method allows to retrieve a respective constraint.
    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }
    
    /// Alias for layoutConstraintWithIdentifier
    public subscript(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return layoutConstraintWithIdentifier(identifier)
    }
    
    /// When storing a reference to a Constraints instance this method allows to set the constant of a respective constraint.
    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }
    
}
