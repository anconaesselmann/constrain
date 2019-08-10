//  Created by Axel Ancona Esselmann on 5/5/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import UIKit

public enum ConstraintIdentifier: String {
    case top = "ConstraintIdentifier.top"
    case leading = "ConstraintIdentifier.leading"
    case trailing = "ConstraintIdentifier.trailing"
    case bottom = "ConstraintIdentifier.bottom"
    case topSafe = "ConstraintIdentifier.topSafe"
    case bottomSafe = "ConstraintIdentifier.bottomSafe"
    case height = "ConstraintIdentifier.height"
    case width = "ConstraintIdentifier.width"
    case centerX = "ConstraintIdentifier.centerX"
    case centerY = "ConstraintIdentifier.centerY"
    case aspectRatio = "ConstraintIdentifier.aspectRatio"
}

public enum Relationship {
    case equal
    case lessThanOrEqual
    case greaterThanOrEqual
}

public typealias ConstraintSet = [NSLayoutConstraint]

/// Constraints is a container of layout constraints for a UIView. It has convenience methods for creating and retrieving constraints.
/// For improved readability constraint-creation methods can be chained.
/// Most methods allow the omition of an anchor or view to be passed in.
/// The superview is used when no view is passed in and the superview's respective anchor is used when the anchor is omitted.
public class Constraints {

    private weak var view: UIView?
    private var constraints: [ConstraintIdentifier: NSLayoutConstraint] = [:]
    
    public var latestConstraint: NSLayoutConstraint?
    public var latestConstraints: ConstraintSet?

    fileprivate init(view: UIView, constraints: [NSLayoutConstraint]) {
        self.view = view
    }

    /// Constrain the view to a layout anchor or to the top of the superview when no anchor is provided.
    @discardableResult
    public func top(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return top(to: nil, constant: constant, by: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the top of the superview when no anchor is provided.
    @discardableResult
    public func top(to anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.topAnchor
        else {
            print("Attempting to create top constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.topAnchor, anchor2: anchor, identifier: .top, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to the top safe area of the superview.
    @discardableResult
    public func topSafe(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view,
            let anchor = view.superview?.topAnchorSafe
        else {
            print("Attempting to create top constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.topAnchor, anchor2: anchor, identifier: .top, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the bottom of the superview when no anchor is provided.
    @discardableResult
    public func bottom(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return bottom(to: nil, constant: constant, by: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the bottom of the superview when no anchor is provided.
    @discardableResult
    public func bottom(to anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.bottomAnchor
        else {
            print("Attempting to create bottom constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.bottomAnchor, anchor2: anchor, identifier: .bottom, constant: -constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to the bottom safe area of the superview.
    @discardableResult
    public func bottomSafe(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view,
            let anchor = view.superview?.bottomAnchorSafe
        else {
            print("Attempting to create bottom constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.bottomAnchor, anchor2: anchor, identifier: .bottom, constant: -constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the leading edge of the superview when no anchor is provided.
    @discardableResult
    public func leading(to anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.leadingAnchor
        else {
            print("Attempting to create leading constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.leadingAnchor, anchor2: anchor, identifier: .leading, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to the leading edge of the superview.
    @discardableResult
    public func leading(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return leading(to: nil, constant: constant, by: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the trailing edge of the superview when no anchor is provided.
    @discardableResult
    public func trailing(to anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.trailingAnchor
        else {
            print("Attempting to create trailing constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.trailingAnchor, anchor2: anchor, identifier: .trailing, constant: -constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to the trailing edge of the superview.
    @discardableResult
    public func trailing(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return trailing(to: nil, constant: constant, by: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the horizontal center point of the superview when no anchor is provided.
    @discardableResult
    public func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.centerXAnchor
        else {
            print("Attempting to create horizontal center constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.centerXAnchor, anchor2: anchor, identifier: .centerX, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to a layout anchor or to the vertical center point of the superview when no anchor is provided.
    @discardableResult
    public func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.centerYAnchor
        else {
            print("Attempting to create vertical ceenter constraint without a reference anchor.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.centerYAnchor, anchor2: anchor, identifier: .centerY, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrain the view to the center of a view or to that of the superview when no view is provided.
    @discardableResult
    public func center(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("Attempting to center view without reference view or superview.")
            return self
        }
        return self
            .centerX(equalTo: viewToFill.centerXAnchor, constant: constant)
            .centerY(equalTo: viewToFill.centerYAnchor, constant: constant)
    }

    /// Apply the height constraint of a view
    @discardableResult
    public func height(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("Attempting to create height constraint without a view.")
            return self
        }
        return applyDimensionConstraint(dimension: view.heightAnchor, identifier: .height, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrains the height of one view to the height of another
    @discardableResult
    public func height(to anchor: NSLayoutDimension, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("Attempting to create height constraint without a view.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.heightAnchor, anchor2: anchor, identifier: .height, constant: constant, relationship: relationship, priority: priority)
    }

    /// Apply the width constraint of a view
    @discardableResult
    public func width(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("Attempting to create width constraint without a view.")
            return self
        }
        return applyDimensionConstraint(dimension: view.widthAnchor, identifier: .width, constant: constant, relationship: relationship, priority: priority)
    }

    /// Constrains the width of one view to the width of another
    @discardableResult
    public func width(to anchor: NSLayoutDimension, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("Attempting to create width constraint without a view.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.widthAnchor, anchor2: anchor, identifier: .width, constant: constant, relationship: relationship, priority: priority)
    }
    
    /// Constrain to square aspect
    @discardableResult
    public func square(by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        return aspectRatio(1, by: relationship, priority: priority)
    }
    
    /// Apply an aspect ratio constraint to a view
    /// Ratio is expressed as width/height
    @discardableResult
    public func aspectRatio(_ ratio: CGFloat, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("Attempting to make aspect ratio constraint without a view.")
            return self
        }
        guard ratio.isFinite else {
            print("Attempting to set aspect ratio to non-finite value.")
            return self
        }

        let constraint: NSLayoutConstraint
        switch relationship {
        case .equal: constraint = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio)
        case .lessThanOrEqual: constraint = view.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: ratio)
        case .greaterThanOrEqual: constraint = view.widthAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: ratio)
        }
        constraint.priority = priority
        finalizeConstraint(constraint, ConstraintIdentifier.aspectRatio)
        return self
    }

    /// Apply the both the height and width constraints of a view
    @discardableResult
    public func size(width: CGFloat, height: CGFloat, by relationship: Relationship = .equal) -> Constraints {
        return self
            .width(width, by: relationship)
            .height(height, by: relationship)
    }
    
    /// Apply the both the height and width constraints of a view based on CGSize
    @discardableResult
    public func size(_ size: CGSize, by relationship: Relationship = .equal) -> Constraints {
        return self.size(width: size.width, height: size.height, by: relationship)
    }

    /// Create a height and width constraints for a square view
    @discardableResult
    public func size(_ size: CGFloat, by relationship: Relationship = .equal) -> Constraints {
        return self.size(width: size, height: size, by: relationship)
    }

    /// Fills the width of the superview or that of the passed in view.
    @discardableResult
    public func fillWidth(of view: UIView? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No view provided for creating fill constraints")
            return self
        }
        return self
            .leading(to: viewToFill.leadingAnchor, constant: constant, by: relationship)
            .trailing(to: viewToFill.trailingAnchor, constant: constant, by: relationship)
    }

    /// Fills the width of the superview.
    @discardableResult
    public func fillWidth(_ constant: CGFloat = 0.0) -> Constraints {
        return fillWidth(of: nil, constant: constant)
    }

    /// Fills the height of the superview or that of the passed in view.
    @discardableResult
    public func fillHeight(of view: UIView? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No view provided for creating fill constraints")
            return self
        }
        return self
            .top(to: viewToFill.topAnchor, constant: constant, by: relationship)
            .bottom(to: viewToFill.bottomAnchor, constant: constant, by: relationship)
    }

    /// Fills the height of the superview.
    @discardableResult
    public func fillHeight(_ constant: CGFloat = 0.0) -> Constraints {
        return fillHeight(of: nil, constant: constant)
    }

    /// iOS 11 introduced safe area layout constraints.
    /// When filling the native UIViewController view, consider a method that aligns to the safe area.
    @discardableResult
    public func fillHeightSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No view provided for creating fill constraints")
            return self
        }
        return self
            .top(to: viewToFill.topAnchorSafe, constant: constant)
            .bottom(to: viewToFill.bottomAnchorSafe, constant: constant)
    }

    /// Fills the both the height and width of the superview or that of the passed in view.
    @discardableResult
    public func fill(_ view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeight(of: view, constant: constant)
    }

    /// iOS 11 introduced safe area layout constraints.
    /// When filling the native UIViewController view, consider a method that aligns to the safe area.
    @discardableResult
    public func fillSafely(_ view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeightSafely(of: view, constant: constant)
    }

    /// When storing a reference to a Constraints instance this method allows to retrieve a respective constraint.
    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }

    /// When storing a reference to a Constraints instance this method allows to set the constant of a respective constraint.
    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }

    private func applyAnchorConstraint<T>(anchor1: NSLayoutAnchor<T>, anchor2: NSLayoutAnchor<T>, identifier: ConstraintIdentifier, constant: CGFloat, relationship: Relationship = .equal, priority: UILayoutPriority) -> Constraints {
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
    
    private func applyDimensionConstraint(dimension: NSLayoutDimension, identifier: ConstraintIdentifier, constant: CGFloat, relationship: Relationship = .equal, priority: UILayoutPriority) -> Constraints {
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
    
    fileprivate func finalizeConstraint(_ constraint: NSLayoutConstraint, _ identifier: ConstraintIdentifier) {
        view?.translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = true
        let identifier = ConstraintIdentifier.aspectRatio
        constraint.identifier = identifier.rawValue
        constraints[identifier] = constraint // TODO: deactivate any existing before overwriting, or allow more than one of same identifier
        latestConstraint = constraint
    }

}

extension UIView {

    /// Returns a Constraint instance which eases creation of NSLayoutConstraints.
    /// Save a reference to the Constraint instance for later access to the layout constraints.
    public var constrain: Constraints {
        return Constraints(view: self, constraints: [])
    }

    public var topAnchorSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    public var bottomAnchorSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
}

public extension UIViewController {
    @discardableResult
    func constrainSubview(_ viewController: UIViewController) -> Constraints {
        view.addSubview(viewController.view)
        return viewController.view.constrain
    }
    
    @discardableResult
    func constrainChild(_ viewController: UIViewController, to view2: UIView? = nil) -> Constraints {
        let superview: UIView = view2 ?? view
        self.addChild(viewController)
        superview.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        return viewController.view.constrain
    }
    
    @discardableResult
    func remove() -> Constraints {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        return self.view.constrain
    }

    @discardableResult
    func constrainSubview(_ subview: UIView) -> Constraints {
        view.addSubview(subview)
        return subview.constrain
    }

}

public extension UIView {
    @discardableResult
    func constrainSubview(_ viewController: UIViewController) -> Constraints {
        addSubview(viewController.view)
        return viewController.view.constrain
    }

    @discardableResult
    func constrainSubview(_ subview: UIView) -> Constraints {
        addSubview(subview)
        return subview.constrain
    }
    
    @discardableResult
    func constrainIn(_ superview: UIView) -> Constraints {
        superview.addSubview(self)
        return self.constrain
    }

    @discardableResult
    func constrainSibling(_ sibling: UIView) -> Constraints {
        if let superview = superview {
            superview.addSubview(sibling)
        } else {
            print("Attempting to constrain sibling without a superview.")
        }
        return sibling.constrain
    }

    @discardableResult
    func constrainSiblingToTrailing(_ sibling: UIView,
                                         constant: CGFloat = 0,
                                         by relationship: Relationship = .equal,
                                         priority: UILayoutPriority = .required) -> Constraints {
        return constrainSibling(sibling).leading(to: self.trailingAnchor, constant: constant, by: relationship, priority: priority)
    }

    @discardableResult
    func constrainSiblingToBottom(_ sibling: UIView,
                                         constant: CGFloat = 0,
                                         by relationship: Relationship = .equal,
                                         priority: UILayoutPriority = .required) -> Constraints {
        return constrainSibling(sibling).top(to: self.bottomAnchor, constant: constant, by: relationship, priority: priority)
    }

}
