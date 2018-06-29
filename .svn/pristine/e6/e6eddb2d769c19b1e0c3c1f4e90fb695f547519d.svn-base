//
//  DLBaseViewController.swift
//  DLCoconutCar
//
//  Created by 董樑 on 2017/8/30.
//  Copyright © 2017年 董樑. All rights reserved.
//

import UIKit
class DLBaseViewController: UIViewController {
        
    var backItem:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font:UIFont.init(name: "PingFangSC-Medium", size: 16),
            NSAttributedStringKey.foregroundColor:NAVTITLECOLOR,
        ];
        self.navigationController?.navigationBar.barTintColor = NAVBGCOLOR;
        self.navigationController?.navigationBar.isTranslucent = false;
        self.edgesForExtendedLayout = UIRectEdge()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: LINECOLOR)
        let backBtn:DLBaseButton = DLBaseButton.init { [weak self](sender) in
            self?.back()
        }
        backBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backBtn.contentHorizontalAlignment = .left
        backBtn.setImage(UIImage.init(named:"back_black"), for: .normal)
        backItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backItem

        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = NAVBGCOLOR
        }
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func back() {
        if (self.navigationController?.viewControllers.count)! < 2 {
            self.dismiss(animated: true, completion: nil)
        }else{
         self.navigationController?.popViewController(animated: true)
        }
    }
    
    func backDeep() {
        if (self.navigationController?.viewControllers.count)! < 2 {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    
    func hiddenBackItem(flag:Bool){
        if flag {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
        }else{
            self.navigationItem.leftBarButtonItem = backItem
        }
    }
}
