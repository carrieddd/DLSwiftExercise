//
//  DLConvenienceRequest.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/4.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
func GetUserInfo(userId:String?, token:String?,completeHandle:@escaping (_ user:DLUserModel?)->Void) {
    
    DLNewWork.request(url: users_getusermsg, method: .get, parameters: ["userId":userId ?? "", "token": token ?? ""], succeed: { (result) in
        
        let dict:[String:Any] = result as! [String : Any]
        let datas:[String:Any] = dict["datas"] as! [String : Any]
        if let userModel = DLUserModel.deserialize(from: datas) {
            DLUserInfo.share.userModel = userModel
            
            completeHandle(userModel)
        }
    }, failure:{
        print($0)
        completeHandle(nil)
    })
}


func GetMobileCode(_ mobile:String,_ sender: UIButton) {
    
    guard NSString.isMobileNumber(mobile) else {
        SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
        return
    }
    sender.isSelected = true
    let parameters = ["mobile":mobile ,"sms_code":"sms_code"] as [String : Any]
    DLNewWork.request(url: users_sendIdentifyingCode,method:.post, parameters: parameters, succeed: { (result) in
        SVProgressHUD.showSuccess(withStatus: "验证码已发送")
    }, failure: {print($0)})
}

func getSystomOption(complete:((_ option:DLSystemShit?)->Void)?){
    DLNewWork.request(url:shunshun_systemoptions,method:.get, parameters:nil, succeed: { (result) in
        let dict:[String:Any] = result as! [String : Any]
        let datas:[String:Any] = dict["datas"] as! [String : Any]
        systemOption = DLSystemShit.deserialize(from: datas)
        complete?(systemOption)
    }, failure: {
        print($0)
        complete?(nil)
    })
}

//订单
let N_order_upload = NSNotification.Name(rawValue:"users_order_notification")
enum orderType:String {
    case expressGoods = "/api/order/expressGoods"
    case deliveredOrder = "/api/order/deliveredOrder"
}
func order(type:orderType,orderId:String, token:String = DLUserInfo.share.token ?? "",complete:((_ errorMsg:String?)->Void)?) {
    
    let parameters = ["orderId":orderId ,"token":token]
    DLNewWork.request(url: type.rawValue,method:.post, parameters: parameters, succeed: { (result) in
        complete?(nil)
    }, failure: {
        print($0)
        complete?($0)
    })
}

//关注
let N_reloation_upload = NSNotification.Name(rawValue:"users_getusermsg_notification")
enum relationType:String {
    case relation = "/api/users/relation"
    case deleterelation = "/api/users/deleterelation"
}

func relation(type:relationType,relationUserId:String,token:String = DLUserInfo.share.token ?? "",complete:((_ errorMsg:String?)->Void)?){
    let parameters = ["userId":relationUserId ,"token":token]
    
    DLNewWork.request(url: type.rawValue,method:.post, parameters: parameters, succeed: { (result) in
        complete?(nil)
    }, failure: {
        print($0)
        complete?($0)
    })

    
}
