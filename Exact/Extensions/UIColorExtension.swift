//
//  UIColorExtension.swift
//  Exact
//
//  Created by Victor Li on 8/12/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

extension CGColor {
    func mix(c1: CGColor, c2: CGColor, percent: CGFloat) -> CGColor  {
        if let comp1 = c1.components, let comp2 = c2.components {
            let c0 = comp1[0] + percent * (comp2[0] - comp1[0])
            let c1 = comp1[1] + percent * (comp2[1] - comp1[1])
            let c2 = comp1[2] + percent * (comp2[2] - comp1[2])
            let c3 = comp1[3] + percent * (comp2[3] - comp1[3])
            return CGColor(srgbRed: c0, green: c1, blue: c2, alpha: c3)

        } else {
            return UIColor.black.cgColor
        }
    }
}
