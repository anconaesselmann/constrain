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
    /// Multiplier is not editable, so you need to replace this constraint to change the ratio
    /// TODO: replacement helper function?
    @discardableResult
    func aspectRatio(_ ratio: CGFloat, by relationship: Relationship = .equal, priority: UILayoutPriority = .required) -> Constraints {
        guard let view = view else {
            print("View fell out of memory.")
            return self
        }
        return applyDimensionMultiplier(dimension1: view.widthAnchor, dimension2: view.heightAnchor, identifier: ConstraintIdentifier.aspectRatio, constant: 0, multiplier: ratio, relationship: relationship, priority: priority)
    }
    
}

public extension UIImage {
    /// may return NaN, but I decided this is preferable to Nil
    /// constrain.aspectRatio() checks .isFinite before setting to avoid crash
    var aspectRatio: CGFloat {
        return size.width/size.height
    }
}

public extension UIImageView {
    @discardableResult
    func constrainAspectToImage() -> Constraints {
        guard let imageAspect = image?.aspectRatio else {
            print("Image is not set.")
            return constrain
        }
        return constrain.aspectRatio(imageAspect)
    }
}
