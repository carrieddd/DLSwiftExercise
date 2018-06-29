//
//  NetworkManager.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/4.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import Alamofire
import SDCAlertView
import SwiftyJSON

let BaseURL = "http://139.196.192.80:28234/fish-web"
//let BaseURL = "http://192.168.1.75:8089/fish-web"   //  周培本机
//let BaseURL = "http://192.168.1.106:28234/fish-web"

private var isReachable: Bool {
    get{
        return NetworkReachabilityManager.init()?.isReachable ?? false
    }
    set{
     }
}

class DLNewWork: NSObject {
    
    class func request(url:String,method:HTTPMethod,parameters:[String:Any]?,succeed:((_ result:Any)->Void)?,failure:((_ error:String)->Void)?){
    
        if !isReachable {
            let alert = AlertController(title: "网络异常", message: "当前网络不可用，请监测网络情况后重新打开APP", preferredStyle: .alert)
            let action = AlertAction(title:"好", style: .normal) { (action) in
            }
            alert.addAction(action)
            alert.present()
            failure?("当前网络不可用，请监测网络情况后重新打开")
            return
        }
    
        let urlShit = BaseURL + url
//    Alamofire.request.
        Alamofire.request(urlShit, method:method, parameters:parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonValue = response.result.value {
                    print("********************************************\n\(String(describing: response.request?.url))\n\\n\(jsonValue)\n*************************************************")
                    let json = JSON(jsonValue)
                    if json["state"].int == 200 {
                        succeed?(json.dictionaryObject ?? [:])
                    }else{
                        failure?(json["message"].stringValue)
                    }
                }
                break
            case .failure(let error):
                print("\(String(describing: response.request?.url))\(error)")
                failure?(error.localizedDescription)
                break
            }
        }
    }
    
//
//    func request(url:String,method:HTTPMethod,parameters:[String: String],handle:@escaping ResponseHandle) {
//
//        if !isReachable {
//            let alert = AlertController(title: "网络异常", message: "当前网络不可用，请监测网络情况后重新打开APP", preferredStyle: .alert)
//            let action = AlertAction(title:"好", style: .normal) { (action) in
//            }
//            alert.addAction(action)
//            alert.present()
//            handle(false, "当前网络不可用，请监测网络情况后重新打开")
//            return
//        }
//
//        let urlShit = BaseURL + url
//        let parShit = parameters
//        if parameters["userId"] != nil {
//
//            if NSString.isEmpty(parameters["userId"]){
//
//                DLUserInfo.verifyUserStatus()
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
//                    handle(false, "userId 为空请重新登录")
//                }
//                return
//            }
//            print( urlShit + "注意 需要添加内容_t/_s")
//        }
       
        //不需要md5加密
//        let parMd5:[String: String] = NSString.md5Parameters(parShit) as! [String : String]
//        let parMd5:[String: String] = parameters
//
//        Alamofire.request(urlShit, method:method, parameters:parMd5).responseJSON { (response) in
//
//            switch response.result {
//            case .success:
//                if let jsonValue = response.result.value {
//                    print("********************************************\n\(String(describing: response.request?.url))\n\\n\(jsonValue)\n*************************************************")
//                    let json = JSON(jsonValue)
//                    if json["code"].int == 200 {
//                        handle(true, json["data"].dictionaryObject as Any)
//                    }else{
//                        if json["code"].int == 401 {
////                            DLUserInfo.logout()
////                            DLUserInfo.verifyUserStatus()
//                        }
//                        if json["code"].int == 399 {
//                            handle(true, jsonValue)
//                        }else{
//                            handle(false, json["message"].string as Any)
//                        }
//                    }
//                }
//                break
//            case .failure(let error):
//                print("\(String(describing: response.request?.url))\(error)")
//                handle(false, error.localizedDescription)
//                break
//            }
//        }
//    }
}

