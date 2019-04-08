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
}

/// Constraints is a container of layout constraints for a UIView. It has convenience methods for creating and retrieving constraints.
/// For improved readability constraint-creation methods can be chained.
/// Most methods allow the omition of an anchor or view to be passed in.
/// The superview is used when no view is passed in and the superview's respective anchor is used when the anchor is omitted.
public class Constraints {

    private weak var view: UIView?
    private var constraints: [ConstraintIdentifier: NSLayoutConstraint] = [:]

    fileprivate init(view: UIView, constraints: [NSLayoutConstraint]) {
        self.view = view
    }

    /// Constrain the view to a layout anchor or to the top of the superview when no anchor is provided.
    @discardableResult
    public func top(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.topAnchor
            else {
                assertionFailure("Attempting to create top constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.topAnchor, anchor2: anchor, identifier: .top, constant: constant)
    }

    @discardableResult
    public func top(_ constant: CGFloat) -> Constraints {
        return top(equalTo: nil, constant: constant)
    }

    /// Constrain the view to a layout anchor or to the bottom of the superview when no anchor is provided.
    @discardableResult
    public func bottom(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.bottomAnchor
            else {
                assertionFailure("Attempting to create bottom constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.bottomAnchor, anchor2: anchor, identifier: .bottom, constant: -constant)
    }

    @discardableResult
    public func bottom(_ constant: CGFloat) -> Constraints {
        return bottom(equalTo: nil, constant: constant)
    }

    /// Constrain the view to a layout anchor or to the leading edge of the superview when no anchor is provided.
    @discardableResult
    public func leading(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.leadingAnchor
            else {
                assertionFailure("Attempting to create leading constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.leadingAnchor, anchor2: anchor, identifier: .leading, constant: constant)
    }

    @discardableResult
    public func leading(_ constant: CGFloat) -> Constraints {
        return leading(equalTo: nil, constant: constant)
    }

    /// Constrain the view to a layout anchor or to the trailing edge of the superview when no anchor is provided.
    @discardableResult
    public func trailing(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.trailingAnchor
            else {
                assertionFailure("Attempting to create trailing constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.trailingAnchor, anchor2: anchor, identifier: .trailing, constant: -constant)
    }

    @discardableResult
    public func trailing(_ constant: CGFloat) -> Constraints {
        return trailing(equalTo: nil, constant: constant)
    }

    /// Constrain the view to a layout anchor or to the horizontal center point of the superview when no anchor is provided.
    @discardableResult
    public func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.centerXAnchor
            else {
                assertionFailure("Attempting to create horizontal center constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.centerXAnchor, anchor2: anchor, identifier: .centerX, constant: constant)
    }

    /// Constrain the view to a layout anchor or to the vertical center point of the superview when no anchor is provided.
    @discardableResult
    public func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard
            let view = view,
            let anchor = anchor ?? view.superview?.centerYAnchor
            else {
                assertionFailure("Attempting to create vertical ceenter constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstrain(anchor1: view.centerYAnchor, anchor2: anchor, identifier: .centerY, constant: constant)
    }

    /// Constrain the view to the center of a view or to that of the superview when no view is provided.
    @discardableResult
    public func center(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            assertionFailure("Attempting to center view without reference view or superview.")
            return self
        }
        return self
            .centerX(equalTo: viewToFill.centerXAnchor, constant: constant)
            .centerY(equalTo: viewToFill.centerYAnchor, constant: constant)
    }

    /// Constrain the view the center of the superview
    @discardableResult
    public func center(constant: CGFloat = 0.0) -> Constraints {
        return center(of: nil, constant: constant)
    }

    /// Apply the height constraint of a view
    @discardableResult
    public func height(_ constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.heightAnchor.constraint(equalToConstant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.height
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    /// Apply the width constraint of a view
    @discardableResult
    public func width(_ constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.widthAnchor.constraint(equalToConstant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.width
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    /// Apply the both the height and width constraints of a view
    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> Constraints {
        return self
            .width(width)
            .height(height)
    }

    /// Create a height and width constraints for a square view
    @discardableResult
    public func size(_ size: CGFloat) -> Constraints {
        return self.size(width: size, height: size)
    }

    /// Fills the widht of the superview or that of the passed in view.
    @discardableResult
    public func fillWidth(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            assertionFailure("No view provided for creating fill constraints")
            return self
        }
        return self
            .leading(equalTo: viewToFill.leadingAnchor, constant: constant)
            .trailing(equalTo: viewToFill.trailingAnchor, constant: constant)
    }

    /// Fills the widht of the superview.
    @discardableResult
    public func fillWidth(constant: CGFloat = 0.0) -> Constraints {
        return fillWidth(of: nil, constant: constant)
    }

    /// Fills the height of the superview or that of the passed in view.
    @discardableResult
    public func fillHeight(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            assertionFailure("No view provided for creating fill constraints")
            return self
        }
        return self
            .top(equalTo: viewToFill.topAnchor, constant: constant)
            .bottom(equalTo: viewToFill.bottomAnchor, constant: constant)
    }

    /// Fills the height of the superview.
    @discardableResult
    public func fillHeight(constant: CGFloat = 0.0) -> Constraints {
        return fillHeight(of: nil, constant: constant)
    }

    /// Introduced in IOS 11 are safe area layout constraints.
    /// When filling the native UIViewController view consider a method that aligns to the safe area.
    @discardableResult
    public func fillHeightSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            assertionFailure("No view provided for creating fill constraints")
            return self
        }
        return self
            .top(equalTo: viewToFill.topAnchorSafe, constant: constant)
            .bottom(equalTo: viewToFill.bottomAnchorSafe, constant: constant)
    }

    /// Introduced in IOS 11 are safe area layout constraints.
    /// When filling the native UIViewController view consider a method that aligns to the safe area.
    @discardableResult
    public func fillHeightSafely(constant: CGFloat = 0.0) -> Constraints {
        return fillHeightSafely(of: nil, constant: constant)
    }

    /// Fills the both the height and width of the superview or that of the passed in view.
    @discardableResult
    public func fill(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeight(of: view, constant: constant)
    }

    /// Fills the both the height and width of the superview.
    @discardableResult
    public func fill(constant: CGFloat = 0.0) -> Constraints {
        return fill(of: nil, constant: constant)
    }

    /// Introduced in IOS 11 are safe area layout constraints.
    /// When filling the native UIViewController view consider a method that aligns to the safe area.
    @discardableResult
    public func fillSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeightSafely(of: view, constant: constant)
    }

    /// Introduced in IOS 11 are safe area layout constraints.
    /// When filling the native UIViewController view consider a method that aligns to the safe area.
    @discardableResult
    public func fillSafely(constant: CGFloat = 0.0) -> Constraints {
        return fillSafely(of: nil, constant: constant)
    }

    /// When storing a reference to a Constraints instance this method allows to retrieve a respective constraint.
    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }

    /// When storing a reference to a Constraints instance this method allows to set the constant of a respective constraint.
    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }

    private func applyAnchorConstrain<T>(anchor1: NSLayoutAnchor<T>, anchor2: NSLayoutAnchor<T>, identifier: ConstraintIdentifier, constant: CGFloat) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = anchor1.constraint(equalTo: anchor2, constant: constant)
        constraint.isActive = true
        let identifier = ConstraintIdentifier.top
        constraint.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

}

extension UIView {

    /// Returns a Constraint instance which eases creation of NSLayoutConstraints.
    /// Save a reference tho the Constraint instance for later access to the layout constraints.
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

    public func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }

    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    @discardableResult
    public func constrainSubview(_ viewController: UIViewController) -> Constraints {
        addSubview(viewController.view)
        return viewController.view.constrain
    }

    @discardableResult
    public func constrainSubview(_ subview: UIView) -> Constraints {
        addSubview(subview)
        return subview.constrain
    }
}


public extension UIViewController {
    @discardableResult
    func constrainSubview(_ viewController: UIViewController) -> Constraints {
        view.addSubview(viewController.view)
        return viewController.view.constrain
    }

    @discardableResult
    func constrainSubview(_ subview: UIView) -> Constraints {
        view.addSubview(subview)
        return subview.constrain
    }

}
