//
//  DLInviteWbViewController.swift
//  LJGeographyFinance
//
//  Created by iOS110 on 2018/1/3.
//  Copyright © 2018年 dongl. All rights reserved.
//

import UIKit
import WebKit

class DLInviteWbViewController: DLWKWebBaseViewController {

    override func viewDidLoad() {
        confs = ["inviteFriend"]
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        super.userContentController(userContentController, didReceive: message)
        if(message.name == "inviteFriend") {
            print(message.body)
//            UMSocialPlatformType_WechatSession      = 1;, //微信聊天
//            UMSocialPlatformType_WechatTimeLine     = 2,//微信朋友圈
//            UMSocialPlatformType_WechatFavorite     = 3,//微信收藏
//            UMSocialPlatformType_QQ                 = 4,//QQ聊天页面
//            UMSocialPlatformType_Qzone              = 5,//qq空间

            var socialPlatformType:UMSocialPlatformType = .unKnown
            let jsonStr:String = message.body as! String
            let jsonData:Data = jsonStr.data(using: .utf8)!
            let requestDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Dictionary<String, Any>
            let index:Int = requestDic?["index"] as! Int
            switch index{
            case 0:
                socialPlatformType = .wechatSession
            case 1:
                socialPlatformType = .wechatTimeLine
            case 2:
                socialPlatformType = .QQ
            case 3:
                socialPlatformType = .qzone

            default:
                break
            }
            
            let msgObject = UMSocialMessageObject.init()
            let shareObj = UMShareWebpageObject.shareObject(withTitle: (requestDic?["title"] as! String) , descr: (requestDic?["content"] as! String), thumImage: UIImage.init(named: "logo"))
            shareObj!.webpageUrl = "\(systemOption?.invite_register ?? "")?token=\(DLUserInfo.share.token ?? "")"
            
            print("\(shareObj!.webpageUrl ?? "")")
            msgObject.shareObject = shareObj
            UMSocialManager.default().share(to: socialPlatformType, messageObject: msgObject, currentViewController: self, completion: { (data, error) in
                
            })

        }

    }
    
    
    private func invite() {
        
        UMSocialUIManager.setPreDefinePlatforms([2, 1, 4, 5])
        UMSocialUIManager.showShareMenuViewInWindow { (platfromeType, userInfo) in

            let msgObject = UMSocialMessageObject.init()
            let shareObj = UMShareWebpageObject.shareObject(withTitle: "邀请好友", descr: "邀请好友", thumImage: UIImage.init(named: "logo"))
            shareObj!.webpageUrl = "\(systemOption?.invite_register ?? "")?token=\(DLUserInfo.share.token ?? "")"

            print("\(shareObj!.webpageUrl ?? "")")
            msgObject.shareObject = shareObj
            UMSocialManager.default().share(to: platfromeType, messageObject: msgObject, currentViewController: self, completion: { (data, error) in

            })
        }
    }    
}
