//
//  Modification.swift
//  constrain
//
//  Created by Greg on 3/25/20.
//

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

    // Not actually constraints:
    case cornerRadius = ".cornerRadius"
    case size = ".size" // size combines .width and .height
}

extension Constraints {
    
    /// When storing a reference to a Constraints instance this method allows to retrieve a respective constraint.
    public func layoutConstraintWithIdentifier(_ identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return constraints[identifier]
    }
    
    /// When storing a reference to a Constraints instance this method allows to set the constant of a respective constraint.
    public func setConstant(_ constant: CGFloat, forIdentifier identifier: ConstraintIdentifier) {
        layoutConstraintWithIdentifier(identifier)?.constant = constant
    }

    @discardableResult
    public func update(_ identifier: ConstraintIdentifier, to constant: CGFloat) -> Self {
        // constrain will start to support setting and updating of view propperties that are not actually NSLayoutConstraints. We have to treat them slightly differently.
        switch identifier {
        case .cornerRadius:
            cornerRadius(constant)
        case .size:
            setConstant(constant, forIdentifier: .width)
            setConstant(constant, forIdentifier: .height)
        default:
            setConstant(constant, forIdentifier: identifier)
        }
        return self
    }

    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> Self {
        view?.layer.cornerRadius = value
        return self
    }
    
}
