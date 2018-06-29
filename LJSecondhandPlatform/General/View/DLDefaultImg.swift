//
//  DLDefaultImg.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/6.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
//默认图片
class shitImageView: UIImageView {
    
    init(url:String) {
        super.init(frame: .zero)
        self.setImageWith(URL.init(string: url), placeholder: UIImage.init(named: "placeholder"))
        ViewRadius(view: self, radius: 5)
        self.contentMode = .scaleAspectFill
        
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        ViewRadius(view: self, radius: 5)
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
