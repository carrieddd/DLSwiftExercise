//
//  String+Extend.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/6.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
extension String {
    func DL_widthForComment(font: UIFont = UIFont.systemFont(ofSize: 14), height: CGFloat = 15) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func DL_heightForComment(font: UIFont = UIFont.systemFont(ofSize: 14), width: CGFloat) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func DL_heightForComment(font: UIFont = UIFont.systemFont(ofSize: 14), width: CGFloat, maxHeight: CGFloat) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}
