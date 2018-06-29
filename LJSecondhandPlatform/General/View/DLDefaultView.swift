//
//  DLDefaultView.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
let DLLINECOLOR = UIColor.withHex(hexString: "E6E6E6")

class DLDefaultLine: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.backgroundColor = DLLINECOLOR
    }
}

class DLDefaultBG: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.backgroundColor = UIColor.clear
    }
}
