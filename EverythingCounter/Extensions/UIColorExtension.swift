//
//  UIColorExtension.swift
//  EverythingCounter
//
//  Created by 伊藤凌也 on 2019/05/22.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(rgba: Int) {
        let r: CGFloat = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((rgba & 0x0000FF00) >>  8) / 255.0
        let a: CGFloat = CGFloat( rgba & 0x000000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// NipponColors.com の色格納列挙型
    /// http://nipponcolors.com/
    ///
    /// - byakugun: 白群
    enum Nippon {
        case byakugun
        
        func color() -> UIColor {
            switch self {
            case .byakugun:
                return UIColor(rgb: 0x78C2C4)
            }
        }
    }
}
