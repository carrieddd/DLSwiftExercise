//
//  DLMyCouponController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/26.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import WebKit

class DLMyCouponController: DLWKWebBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        let backBtn:DLBaseButton = DLBaseButton.init { [weak self](sender) in
            let adress = systemOption?.coupon_event ?? ""
            let p = DLCouponGuideController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")")
            self?.navigationController?.pushViewController(p, animated: true)
        }
        backBtn.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        backBtn.contentHorizontalAlignment = .right
        backBtn.setImage(UIImage.init(named:"couponQ"), for: .normal)
        backItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.rightBarButtonItem = backItem

    }
}

