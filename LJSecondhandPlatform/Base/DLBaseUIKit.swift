//
//  DLBaseUIKit.swift
//  DLUnlikeNews
//
//  Created by 董樑 on 2017/9/6.
//  Copyright © 2017年 董樑. All rights reserved.
//

import UIKit


protocol scrollClickDelegate {
    func scrollClick()
}

class DLBaseScrollView: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DLPageScroll: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DLClickScroll: DLBaseScrollView {
    
    var clickDelegate:scrollClickDelegate?
    
    override init() {
        super.init()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(scrollClick))
        self.addGestureRecognizer(tap)
    }
    
    @objc func scrollClick()  {
        self.clickDelegate?.scrollClick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DLTableView: UITableView {
    init(vc:UIViewController,style:UITableViewStyle) {
        super.init(frame: .zero, style: style)
        self._setup()
//        self.dataSource = (vc as! UITableViewDataSource)
//        self.delegate = (vc as! UITableViewDelegate)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.separatorColor = LINECOLOR;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedRowHeight = 0;
        self.backgroundColor = BackGroundColor
        self.tableFooterView = UIView()
        self.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 1))
        if #available(iOS 11.0, *){
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func registerNib(nibName:String){
        self .register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    
}


// MARK: *******Button*******
let btnTitleColor = UIColor.withHex(hexString:"666666")
//let btnSelTitleColor = UIColor.withHex(hexString:"F44858")
let btnBackColor = UIColor.withHex(hexString:"FE7237")
let btnHighLightColor = GRAYCOLOR
let btnDisabledColor = GRAYCOLOR
let btnSelectedColor = UIColor.clear
class DLBaseButton: UIButton ,NSCopying{
    func copy(with zone: NSZone? = nil) -> Any {
        let theCopyObj = UIButton.init(frame: self.frame)
        return theCopyObj
    }
    
    typealias ClickHandle = (UIButton) -> Void
     var clickHandle:ClickHandle?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
//        self.addTarget(self, action: #selector(_click), for: .touchUpInside)
    }
    
    init(handle:@escaping ClickHandle) {
        super.init(frame: CGRect.zero)
        self.clickHandle = handle
        self.addTarget(self, action: #selector(_click), for: .touchUpInside)
//        self._setup()
    }
    
    func _setup() {
        ViewRadius(view: self, radius: 3)
        self.setTitleColor(btnTitleColor, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setBackgroundImage(UIImage.imageWithColor(color: btnBackColor), for: UIControlState.normal)
        self.setBackgroundImage(UIImage.imageWithColor(color: btnSelectedColor), for: UIControlState.selected)
        self.setBackgroundImage(UIImage.imageWithColor(color: btnHighLightColor), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage.imageWithColor(color: btnDisabledColor), for: UIControlState.disabled)
    }
    
    @objc func _click() {
        
        if let clickHandle = clickHandle {
            clickHandle(self)
        }
    }
}

class DLNAVBtn: DLBaseButton {
    override init(handle: @escaping ClickHandle) {
        super.init(handle: handle)
        self._setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func _setup() {
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
}


class DLVerifyBtn: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    func _setup() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.backgroundColor = .white
        self.setTitle(" 去认证 ", for: .normal)
        ViewBoardRadius(view: self, radius: 4, width: 1, color: OrangeColor)
        self.setTitleColor(OrangeColor, for: UIControlState.normal)
    }
    
    var _status = 0
    var status:Int?{
        get{
            return _status
        }
        set{
            _status = (newValue as! Int) 
            switch newValue {
            case 0:
                self.setTitle(" 去认证 ", for: .normal)
                ViewBoardRadius(view: self, radius: 4, width: 1, color: OrangeColor)
                self.setTitleColor(OrangeColor, for: UIControlState.normal)
            case 1:
                self.setTitle(" 已认证 ", for: .normal)
                ViewBoardRadius(view: self, radius: 4, width: 1, color: GRAYCOLOR)
                self.setTitleColor(GRAYCOLOR, for: UIControlState.normal)
            default:
                break
            }
        }
    }
}



class DLButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setup()
    }
    
    func _setup() {
        ViewBoardRadius(view: self, radius: 4, width: 1, color: OrangeColor)
        self.setTitleColor(OrangeColor, for: UIControlState.normal)
    }
}


class DLLine: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = LINECOLOR
    }
}

class DLCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

// MARK: *******Label*******
class DLBaseLabel:UILabel{
    init(textFont:CGFloat,textColor:UIColor,textAligent:NSTextAlignment) {
        super.init(frame: CGRect.zero)
        self.font = UIFont.systemFont(ofSize: textFont)
        self.textColor = textColor
        self.textAlignment = textAligent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

