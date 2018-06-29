//
//  DLPayManager.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/15.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
let N_paysucceed_upload = NSNotification.Name(rawValue:"users_pay_succeed")


func dl_alipay(orderStr:String){
    let jsonData:Data = orderStr.data(using: .utf8)!
    let requestDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Dictionary<String, String>
    AlipaySDK.defaultService().payOrder(requestDic!["orderInfo"], fromScheme: "LJSecondhandPlatformURL") { (result) in
    }
}

func dl_wxpay(orderStr:String) {
    
    let jsonData:Data = orderStr.data(using: .utf8)!
    let requestDic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Dictionary<String, String>

    let request:PayReq = PayReq.init()
    request.nonceStr = requestDic!["nonceStr"]
    request.sign = requestDic!["sign"]
    request.timeStamp = UInt32("\(requestDic!["timeStamp"] ?? "0")")!
    request.package = requestDic!["package"]
    request.partnerId = requestDic!["mchId"]
    request.prepayId = requestDic!["orderId"]
//    request.openID
//    request.ke
    WXApi.send(request)
}

class DLPaymentManager: NSObject,WXApiDelegate {
    static var share = DLPaymentManager()

    func onResp(_ resp: BaseResp!) {

        switch resp.errCode{
        case 0:
            NotificationCenter.default.post(name: N_paysucceed_upload, object: nil)
            break
        default:
            SVProgressHUD.showInfo(withStatus: resp.errStr ?? "支付失败")
        }

//        if resp.isKind(of: PayResp.classForCoder()) {
//            let response:PayResp = resp as! PayResp
        //    }
        }

}

