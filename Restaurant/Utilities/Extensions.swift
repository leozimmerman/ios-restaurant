//
//  Extensions.swift
//  Restaurant
//
//  Created by Leonardo Zimmerman on 18/02/2021.
//  Copyright © 2021 Leonardo Zimmerman. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setTranslucent() {
        isTranslucent = true
        backgroundColor = .clear
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }
}

extension UIView {
    func setupRoundedCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        clipsToBounds = true
        if let mask = corners.mask {
            layer.maskedCorners = mask
        }
    }
}

extension UIRectCorner {
    var mask: CACornerMask? {
        guard self != .allCorners else { return nil }
        var cornerMask = CACornerMask()
        if(contains(.topLeft)) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if(contains(.topRight)) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if(contains(.bottomLeft)) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if(contains(.bottomRight)) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}
