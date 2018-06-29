//
//  DLDefaultButton.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import SDCAlertView
class C99Btn_15: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTHGARY_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
    }
}


class DLDefaultButton_h0: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTHGARY_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
    }
}

class DLDefaultButton_h3: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTDARK_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
    }
}

class C66Btn_14: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTHGARY_2, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
    }
}

class C99Btn_13: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTHGARY_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 13)
    }
}

class OrangeBtn_13: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTORANGE_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 13)
    }
}

class DLDefaultButton_h1: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(TEXTHGARY_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        
    }
}

class DLMobileCodeButton: TimeButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    func _setup() {
        self.setTitleColor(DefaultRed, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        ViewBoardRadius(view: self, radius: 3, width: 1, color: DefaultRed)
    }
}

class DLDarkRadiusButton: TimeButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    func _setup() {
        self.setTitleColor(TEXTDARK_1, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        ViewBoardRadius(view: self, radius: 3, width: 1, color: TEXTDARK_1)
    }
}


class DLDefaultButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    func _setup() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 17)
        self.setBackgroundImage(UIImage.init(named: "personal_bg"), for: .normal)
        ViewRadius(view: self, radius: 4)
    }
}

class DLRelationShipButton: DLBaseButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var bindUserId:String?
    
    override func _setup() {
        self.addTarget(self, action: #selector(_click), for: .touchUpInside)
        self.setTitleColor(OrangeColor, for: .normal)
        self.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        ViewBoardRadius(view: self, radius: 3, width: 1, color: OrangeColor)
        self.setTitle("+关注", for: .normal)
        self.setTitle("已关注", for: .selected)
    }
    
    func relationRequest() {
        self.isUserInteractionEnabled = false
        relation(type: self.isSelected ? .deleterelation:.relation, relationUserId: bindUserId!) { (errorCode) in
            self.isUserInteractionEnabled = true
            if errorCode == nil{
                self.isSelected = !self.isSelected
                NotificationCenter.default.post(name: N_reloation_upload, object: nil)
            }else{
                SVProgressHUD.showInfo(withStatus: errorCode)
            }
        }
    }
    
    override func _click() {
        super._click()
        
        guard bindUserId != nil else {
            SVProgressHUD.showInfo(withStatus: "userId 获取有误")
            return
        }
        
        
        if self.isSelected {
            let alert = AlertController(title: "取消关注", message: "点击确认取消关注", preferredStyle: .actionSheet)
            let cancelAction = AlertAction(title: "取消", style: .destructive) { [weak self](action) in
                alert.dismiss()
            }
            let action = AlertAction(title: "确认", style: .normal, handler: { [weak self](action) in
                self?.relationRequest()
            })
            alert.addAction(cancelAction)
            alert.addAction(action)
            alert.present()
        }else{
            self.relationRequest()
        }
    }
}

