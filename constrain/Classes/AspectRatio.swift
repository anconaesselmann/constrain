//
//  AspectRatio.swift
//  constrain
//
//  Created by Greg on 8/10/19.
//

import UIKit

public extension Constraints {
    
    /// Apply an aspect ratio constraint to a view
    /// Ratio is expressed as width/height
    /// Checks that ratio is finite before applying (avoid divide by zero errors)
    /// Multiplier is not editable, so you need to replace this constraint to change the ratio, hence the optional parameter
    @discardableResult
    func aspectRatio(_ ratio: CGFloat, by relationship: Relationship = .equal, priority: UILayoutPriority = .required, replacingExisting: Bool = true) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        if replacingExisting {
            removeConstraintsWithIdentifier(.aspectRatio)
        }
        return applyDimensionMultiplier(dimension1: view.widthAnchor, dimension2: view.heightAnchor, identifier: ConstraintIdentifier.aspectRatio, constant: 0, multiplier: ratio, relationship: relationship, priority: priority)
    }
    
}

public extension UIImage {
    /// may return NaN, but I decided this is preferable to Nil
    /// constrain.aspectRatio() checks for `.isFinite` before setting to avoid crash
    var aspectRatio: CGFloat {
        return size.aspectRatio
    }
}

public extension CGSize {
    /// may return NaN, but I decided this is preferable to Nil
    /// constrain.aspectRatio() checks for `.isFinite` before setting to avoid crash
    var aspectRatio: CGFloat {
        return width/height
    }
}

public extension UIImageView {
    @discardableResult
    func constrainAspectToImage() -> Constraints {
        guard let image = image else {
            print("Image is not set.")
            return constrain
        }
        return constrainAspect(to: image)
    }
    
    @discardableResult
    func constrainAspect(to image: UIImage) -> Constraints {
        return constrain.aspectRatio(image.aspectRatio)
    }
}
