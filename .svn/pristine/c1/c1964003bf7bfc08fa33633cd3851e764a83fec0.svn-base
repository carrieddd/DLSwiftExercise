//
//  DLCouponGuideController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/27.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import WebKit

class DLCouponGuideController: DLWKWebBaseViewController {
    
    override func viewDidLoad() {
        confs = ["fun1","fun2","fun3","fun4"]
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        super.userContentController(userContentController, didReceive: message)
        print(message.name)
        let selector:Selector = Selector.init(message.name)
        self.perform(selector)
    }
    
    @objc func fun1() {
        print("去登录")
    }
    @objc func fun2() {
        let p = UINavigationController(rootViewController: DLPublicController.init(configure: nil))
        self.present(p, animated: true, completion: nil)
    }
    @objc func fun3() {
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[0]

    }
    @objc func fun4() {
        let adress = systemOption?.invite_friend ?? ""
        let v = DLInviteWbViewController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")")
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)

    }

}
