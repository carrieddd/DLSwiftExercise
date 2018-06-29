//
//  DLTabBarViewController.swift
//  DLUnlikeNews
//
//  Created by 董樑 on 2017/9/6.
//  Copyright © 2017年 董樑. All rights reserved.
//

import UIKit
import SDCAlertView

class DLTabBarViewController: UITabBarController {
    
    
    let TABBAR_BGC = UIColor.init(red: 247, green: 247, blue: 247, alpha: 1)
    var lastSelection = 0
    
    let publicVC = UINavigationController(rootViewController: DLPublicController.init(configure: nil))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupSubControllers()
        addNotification()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addNotification(){
//        NotificationCenter.default.rx.notification(N_paysucceed_upload).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
//            self?.selectedViewController = self?.viewControllers?[2]
//            
//        }
    }
    
    func _setupSubControllers() {
        
//        let homeNV = UINavigationController(rootViewController:DLHomeViewController(tableStyle:.grouped))
        let homeNV = UINavigationController(rootViewController:DLHomeBaseViewController.init())

        
        let personalNV = UINavigationController(rootViewController: DLPersonalController(tableStyle:.plain))
        
        let viewControllerArr = [homeNV,UIViewController(),personalNV]
        self.viewControllers = viewControllerArr
        self.selectedIndex = 0

        let imageView = UIImageView.init(image: UIImage.init(named: "tabbarLineBG2"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect.init(x: 0, y: 0, width: dScreenW, height: 49)
        
        self.tabBar.insertSubview(imageView, at: 0)
        self.tabBar.backgroundImage = UIImage.init(color: .clear)
        self.tabBar.shadowImage = UIImage.init()
        self.tabBar.backgroundColor = .clear
//        self.tabBar.clipsToBounds = true
//        self.tabBar.tintColor = UIColor.withHex(hexString: "FF7739")
        
        let tabBarItem0 = self.tabBar.items?[0]
        tabBarItem0?.imageInsets = UIEdgeInsetsMake(4, 0, -5, 0)
        let tabBarItem1 = self.tabBar.items?[1]
        tabBarItem1?.imageInsets = UIEdgeInsetsMake(4, 0, -5, 0)
        let tabBarItem2 = self.tabBar.items?[2]
        tabBarItem2?.imageInsets = UIEdgeInsetsMake(4, 0, -5, 0)
        
        tabBarItem0?.image = UIImage.init(named: "shouye")
        tabBarItem1?.image = UIImage.init(named: "fabu")
        tabBarItem2?.image = UIImage.init(named: "wode")

        tabBarItem0?.selectedImage = UIImage.init(named: "shouyea")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBarItem1?.selectedImage = UIImage.init(named: "fabua")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabBarItem2?.selectedImage = UIImage.init(named: "wodea")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.isEqual(tabBar.items?[1]) {
            guard DLUserInfo.verifyToken() else {
                return
            }
            self.present(publicVC, animated: true) {
                self.selectedViewController = self.viewControllers?[0]
            }
        }
    }
}
