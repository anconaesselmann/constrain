//  Created by Axel Ancona Esselmann on 5/5/18.
//  Copyright © 2018 Vida. All rights reserved.
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

public class Constraints {

    private weak var view: UIView?
    private var constraints: [ConstraintIdentifier: NSLayoutConstraint] = [:]

    fileprivate init(view: UIView, constraints: [NSLayoutConstraint]) {
        self.view = view
    }

    @discardableResult
    public func top(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.top
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func bottom(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.bottom
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func leading(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.leading
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func trailing(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.trailingAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.trailing
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func centerX(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.centerX
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func centerY(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> Constraints {
        view?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = view?.centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint?.isActive = true
        let identifier = ConstraintIdentifier.centerY
        constraint?.identifier = identifier.rawValue
        constraints[identifier] = constraint
        return self
    }

    @discardableResult
    public func center(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No superview")
            return self
        }
        return self
            .centerX(equalTo: viewToFill.centerXAnchor, constant: constant)
            .centerY(equalTo: viewToFill.centerYAnchor, constant: constant)
    }

    @discardableResult
    public func center(constant: CGFloat = 0.0) -> Constraints {
        return center(of: nil, constant: constant)
    }

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

    @discardableResult
    public func size(width: CGFloat, height: CGFloat) -> Constraints {
        return self
            .width(width)
            .height(height)
    }

    @discardableResult
    public func size(_ size: CGFloat) -> Constraints {
        return self.size(width: size, height: size)
    }

    @discardableResult
    public func fillWidht(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No superview")
            return self
        }
        return self
            .leading(equalTo: viewToFill.leadingAnchor, constant: constant)
            .trailing(equalTo: viewToFill.trailingAnchor, constant: constant)
    }

    @discardableResult
    public func fillWidht(constant: CGFloat = 0.0) -> Constraints {
        return fillWidht(of: nil, constant: constant)
    }

    @discardableResult
    public func fillHeight(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No superview")
            return self
        }
        return self
            .top(equalTo: viewToFill.topAnchor, constant: constant)
            .bottom(equalTo: viewToFill.bottomAnchor, constant: constant)
    }

    @discardableResult
    public func fillHeight(constant: CGFloat = 0.0) -> Constraints {
        return fillHeight(of: nil, constant: constant)
    }

    @discardableResult
    public func fillHeightSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        guard let viewToFill = view ?? self.view?.superview else {
            print("No superview")
            return self
        }
        return self
            .top(equalTo: viewToFill.topAnchorSafe, constant: constant)
            .bottom(equalTo: viewToFill.bottomAnchorSafe, constant: constant)
    }

    @discardableResult
    public func fillHeightSafely(constant: CGFloat = 0.0) -> Constraints {
        return fillHeightSafely(of: nil, constant: constant)
    }

    @discardableResult
    public func fill(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidht(of: view, constant: constant)
            .fillHeight(of: view, constant: constant)
    }

    @discardableResult
    public func fill(constant: CGFloat = 0.0) -> Constraints {
        return fill(of: nil, constant: constant)
    }

    @discardableResult
    public func fillSafely(of view: UIView? = nil, constant: CGFloat = 0.0) -> Constraints {
        return self
            .fillWidht(of: view, constant: constant)
            .fillHeightSafely(of: view, constant: constant)
    }

    @discardableResult
    public func fillSafely(constant: CGFloat = 0.0) -> Constraints {
        return fillSafely(of: nil, constant: constant)
    }

    @discardableResult
    func constant(_ constant: CGFloat) -> Constraints {
        for (_, constraint) in constraints {
            var constant = constant
            switch constraint.identifier ?? "" {
            case ConstraintIdentifier.trailing.rawValue,
                 ConstraintIdentifier.bottom.rawValue,
                 ConstraintIdentifier.bottomSafe.rawValue : constant = -constant
            default: ()
            }
            constraint.constant = constant
        }
        return self
    }

    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }

    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }

}

extension UIView {

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
