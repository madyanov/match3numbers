//
//  UIColor+Theme.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

extension UIColor {
    static var backgroundPrimary = dynamicColor(light: .white,
                                                dark: .black)

    static var backgroundSecondary = dynamicColor(light: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1),
                                                  dark: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))
}

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}
