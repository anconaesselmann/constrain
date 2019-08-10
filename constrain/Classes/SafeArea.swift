//
//  SafeArea.swift
//  constrain
//
//  Created by Greg2 on 8/10/19.
//

import Foundation

// Safe areas
public extension UIView {
    var topAnchorSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    var bottomAnchorSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
}

public extension Constraints {
    
    /// Constrain the view to the top safe area of the superview.
    @discardableResult
    func topSafe(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
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
    func bottomSafe(_ constant: CGFloat = 0.0, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view,
            let anchor = view.superview?.bottomAnchorSafe
            else {
                print("Attempting to create bottom constraint without a reference anchor.")
                return self
        }
        return applyAnchorConstraint(anchor1: view.bottomAnchor, anchor2: anchor, identifier: .bottom, constant: -constant, relationship: relationship, priority: priority)
    }
    
    /// iOS 11 introduced safe area layout constraints.
    /// When filling the native UIViewController view, consider a method that aligns to the safe area.
    @discardableResult
    func fillHeightSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
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
    func fillSafely(_ view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidth(of: view, constant: constant)
            .fillHeightSafely(of: view, constant: constant)
    }
}
