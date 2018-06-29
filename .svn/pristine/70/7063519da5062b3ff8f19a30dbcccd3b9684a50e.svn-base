//
//  UIKit+Extend.swift
//  DLUnlikeNews
//
//  Created by 董樑 on 2017/9/6.
//  Copyright © 2017年 董樑. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
}
