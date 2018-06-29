//
//  DLQiNiuManager.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/7.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import UIKit

private let qnUploadManager = QNUploadManager.init()
var coverK:String?
var imgK:String?

private func getQiNiuTokenKey(imgCount:Int = 1,complete:@escaping (_ token:String,_ keys:[String],_ domain:String)->Void){
    
    let parameters = [
        "userId":DLUserInfo.share.userModel?.user_id ?? "",
        "keynum":"\(imgCount)"] as [String : Any]
    
    DLNewWork.request(url:common_getToken ,method:.get, parameters: parameters, succeed: { (result) in
        let dict:[String:Any] = result as! Dictionary
        let datas:[String:Any] = dict["datas"] as! [String : Any]
        let token:String = datas["token"] as? String ?? ""
        let key:[String] = datas["key"] as? [String] ?? []
        let domain:String = datas["domain"] as? String ?? ""
        complete(token,key,domain)
    }, failure: {
        print($0)
        complete("",[],"")
    })
}


func uploadImg(imgs:[UIImage],complete:@escaping ((_ coverKey:String,_ imgKey:String)->Void)) {
    
//func uploadImg(coverImage:UIImage,imgs:[UIImage],complete:@escaping ((_ coverKey:String,_ imgKey:String)->Void)) {
    
    let group = DispatchGroup()
    let imgGroup = imgs.map{UIImage.fixOrientation($0) ?? UIImage.init()}
    let imgCover = UIImage.fixOrientation(imgs.first)
    imgK = ""
    coverK = ""
//    imgGroup.removeFirst()
    
    group.enter()
    getQiNiuTokenKey { (token, keys, domain) in
        group.enter()
        let coverData = UIImagePNGRepresentation(imgCover!)
        qnUploadManager?.put(coverData, key: keys.first, token: token, complete: { (info, key, resp) in
            coverK = "\(domain)/\(key ?? "")"
            if imgGroup.count == 1{imgK = ",\(domain)/\(key!)"}
            group.leave()
        }, option: nil)
        group.leave()
    }
    
    if imgGroup.count > 1 {
        group.enter()
        getQiNiuTokenKey(imgCount: imgGroup.count, complete: {(token, keys, domain) in
            for (index, key) in keys.enumerated(){
                group.enter()
                let imgData = UIImageJPEGRepresentation(imgGroup[index], 0.3)
                //                UIImagePNGRepresentation(imgGroup[index])
                
                qnUploadManager?.put(imgData, key: key, token: token, complete: { (info, key, resp) in
                    imgK = "\(imgK ?? ""),\(domain)/\(key ?? "")"
                    group.leave()
                }, option: nil)
            }
            group.leave()
        })
    }

    group.notify(queue: .main) {
        complete(coverK!, imgK!)
    }
    
}
