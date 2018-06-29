//
//  DLPayWebViewController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/15.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import WebKit

class DLPayWebViewController: DLWKWebBaseViewController {

    var orderId:String?
    var success:Bool = false
    
    override init(urlStr: String) {
        super.init(urlStr: urlStr)
        confs.append(contentsOf: ["aliPay","wxPay","updateOrder","close"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.rx.notification(N_paysucceed_upload).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            
            self?.success = true
            var adress = systemOption?.pay_success ?? ""
            adress = "\(adress)?token=\(DLUserInfo.share.token ?? "")&orderId=\(self?.orderId ?? "")"
            self?.webView.load( URLRequest.init(url: URL.init(string: adress)!))
            
            print("交易成功")
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        super.userContentController(userContentController, didReceive: message)
        
        if(message.name == "aliPay") {
            dl_alipay(orderStr:message.body as! String)
        }
        
        if(message.name == "wxPay") {
            dl_wxpay(orderStr: message.body as! String)
        }
        
        if message.name == "updateOrder" {
            NotificationCenter.default.post(name: N_order_upload, object: nil)
        }
        
        if message.name == "close" {
            self.backDeep()
        }
    }
    
    override func back() {
        
        if success {
            self.backDeep()
            return
        }
        
        if webView.canGoBack {
            self.webView.goBack()
        }else{
            super.back()
        }
    }
}
