//
//  BaseTypes.swift
//  constrain
//
//  Created by Greg on 8/10/19.
//

import UIKit

extension Constraints {
    
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
}


// Safety
extension Constraints {
    
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
    
}

// Height and width stuff
extension Constraints {
    /// Apply the height constraint of a view
    @discardableResult
    public func height(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        return applyDimensionConstraint(dimension: view.heightAnchor, identifier: .height, constant: constant, relationship: relationship, priority: priority)
    }
    
    /// Constrains the height of one view to the height of another
    @discardableResult
    public func height(to anchor: NSLayoutDimension, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.heightAnchor, anchor2: anchor, identifier: .height, constant: constant, relationship: relationship, priority: priority)
    }
    
    /// Apply the width constraint of a view
    @discardableResult
    public func width(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        return applyDimensionConstraint(dimension: view.widthAnchor, identifier: .width, constant: constant, relationship: relationship, priority: priority)
    }
    
    /// Constrains the width of one view to the width of another
    @discardableResult
    public func width(to anchor: NSLayoutDimension, constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        return applyAnchorConstraint(anchor1: view.widthAnchor, anchor2: anchor, identifier: .width, constant: constant, relationship: relationship, priority: priority)
    }
    
}

// C-c-c-c-combos
extension Constraints {
    
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
    
    /// Fills the width of the superview or that of the passed in view.
    @discardableResult
    public func fillWidth(of view: UIView? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("Attempting to fill width without reference view or superview.")
            return self
        }
        return self
            .leading(to: viewToFill.leadingAnchor, constant: constant, by: relationship)
            .trailing(to: viewToFill.trailingAnchor, constant: constant, by: relationship)
    }
    
    /// Fills the height of the superview or that of the passed in view.
    @discardableResult
    public func fillHeight(of view: UIView? = nil, constant: CGFloat = 0.0, by relationship: Relationship = .equal) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("Attempting to fill height without reference view or superview.")
            return self
        }
        return self
            .top(to: viewToFill.topAnchor, constant: constant, by: relationship)
            .bottom(to: viewToFill.bottomAnchor, constant: constant, by: relationship)
    }
    
    /// Fills the both the height and width of the superview or that of the passed in view.
    @discardableResult
    public func fill(_ view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeight(of: view, constant: constant)
    }
    
    /// Apply the both the height and width constraints of a view
    @discardableResult
    public func size(width: CGFloat, height: CGFloat, by relationship: Relationship = .equal) -> Constraints {
        return self
            .width(width, by: relationship)
            .height(height, by: relationship)
    }
    
    /// iOS 11 introduced safe area layout constraints.
    /// When filling the native UIViewController view, consider a method that aligns to the safe area.
    @discardableResult
    public func fillHeightSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("Attempting to fill height without reference view or superview.")
            return self
        }
        return self
            .top(to: viewToFill.topAnchorSafe, constant: constant)
            .bottom(to: viewToFill.bottomAnchorSafe, constant: constant)
    }
    
    /// iOS 11 introduced safe area layout constraints.
    /// When filling the native UIViewController view, consider a method that aligns to the safe area.
    @discardableResult
    public func fillSafely(_ view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeightSafely(of: view, constant: constant)
    }
    
}
