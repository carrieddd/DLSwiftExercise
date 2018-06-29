//
//  UserInfo.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/4.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import HandyJSON

let N_users_getusermsg = NSNotification.Name(rawValue:"users_getusermsg_notification")
let N_users_logout = NSNotification.Name(rawValue:"users_logout_notification")


class DLUserInfo: HandyJSON {
    static var share = DLUserInfo()
    required init() {}

    var _token:String = DLUserInfo.haveCacheToken().1
    var token:String?{
        get{
            return _token
        }
        set{
            _token = newValue!
            saveToken(_token )
            
            guard !NSString.isEmpty(newValue) else {
                return
            }
            
            GetUserInfo(userId: nil, token: _token, completeHandle:{_ in print("用户信息\(DLUserInfo.share.userModel?.mobile ?? "手机号为空！！！！")获取成功")
                NotificationCenter.default.post(name: N_users_getusermsg, object: nil)
            })
        }
    }
    
    var userModel:DLUserModel?
    
    private func saveToken(_ token:String){
        UserDefaults.standard.set(token, forKey: token_Key)
    }
    
    class func verifyToken(uploadUser:Bool = true) -> Bool {
        
        guard DLUserInfo.haveCacheToken().0 else {
            let nav = UINavigationController.init(rootViewController: DLLoginController.init(nibName: "DLLoginController", bundle: nil))
            UIViewController.currentViewController()?.present(nav, animated:true , completion: nil)
            return false
        }
        if uploadUser {
            DLUserInfo.share.token = DLUserInfo.haveCacheToken().1
        }
        return DLUserInfo.haveCacheToken().0
    }
}

private let token_Key = "qunimaToken"

extension DLUserInfo{
    //验证是否本地有token
     class func haveCacheToken() -> (Bool,String){
        if let userId = UserDefaults.standard.string(forKey:token_Key)
        {
            
            return (!NSString.isEmpty(userId), userId)
        }else{
            return (false, "")
        }
    }

    //登出
    func logout(complete:(()->Void)?) {
        token = ""
        DLUserInfo.share.userModel = nil
        NotificationCenter.default.post(name: N_users_logout, object: nil)
        complete?()
    }
    
}
