//
//  UIFont+Rounded.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        var font = UIFont.systemFont(ofSize: size, weight: weight)

        if #available(iOS 13.0, *), let descriptor = font.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        }

        return font
    }
}
