//
//  DLWKWebBaseViewController.swift
//  LJGeographyFinance
//
//  Created by dongl on 2017/12/21.
//  Copyright © 2017年 dongl. All rights reserved.
//

import UIKit
import WebKit
import SDCAlertView
class DLWKWebBaseViewController: DLBaseViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler  {
    
    var keys:[String] = []
    var confs:[String] = ["uploadUserInfo","call"]
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "uploadUserInfo") {
            NotificationCenter.default.post(name: N_users_getusermsg, object: nil)
        }
        if(message.name == "call") {
            let alert = AlertController(title: "电话联系", message: "呼叫号码：\(message.body)", preferredStyle: .alert)
            let cancelAction = AlertAction(title: "取消", style: .destructive) { (action) in
            }
            let action = AlertAction(title: "确认", style: .normal, handler: { [weak self](action) in
                UIApplication.shared.openURL(NSURL.init(string: "tel://\(message.body)")! as URL)
            })
            alert.addAction(cancelAction)
            alert.addAction(action)
            alert.present()
        }

    }
    
   var webView : WKWebView = {
        let web = WKWebView(frame: CGRect.zero)
        return web
    }()
    
    var progressView:UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = DEFAULTCOLOR
        progress.trackTintColor = .clear
        return progress
    }()
    
    deinit {
        for key in keys {
            self.webView.removeObserver(self, forKeyPath: key)
        }
    }
    
    var url:NSURL!
    
    
    init(urlStr:String) {
        super.init(nibName: nil, bundle: nil)
        self.url =  NSURL(string:urlStr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        confs.append(contentsOf: ["uploadUserInfo","call"])
        for conf in confs{
            webView.configuration.userContentController.add(self, name:conf)
        }

        view.addSubview(self.progressView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(self.webView)
        
        keys.append("title")
        for key in keys {
            self.webView.addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions.new, context: nil)
        }
        
//        for conf in confs{
//            webView.configuration.userContentController.add(self, name:conf)
//        }


        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        if NSString.isEmpty(url.absoluteString) {
            return
        }
        let requst = NSURLRequest(url: url as URL)
        webView.load(requst as URLRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.progressView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:2)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.progressView.progress = 0.0
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        /// 获取网页title
        self.navigationItem.title = self.webView.title
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        return nil
    }
    
    //confirm弹框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (_) in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (_) in
            completionHandler(false)
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if object as?WKWebView == self.webView{
                self.navigationItem.title = self.webView.title
                print("\(self.webView.url!)")
            }
        }
    }
    
    override func back() {
        if (webView.canGoBack) {
            webView.goBack()
        } else {
            for conf in confs{
                webView.configuration.userContentController.removeScriptMessageHandler(forName: conf)
            }
            super.back()
        }
    }

}
