//
//  DLUserModel.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/4.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import HandyJSON
struct DLUserModel: HandyJSON {
    var onsalegoods:Int?
    var buyednum:Int?
    var sellednum:Int?
    var favoritenum:Int?
    var myRelations:Int?
    var myFans:Int?

    var avatar:String?
    var balance:String? 
    var email:String?
    var mobile:String?
    var points:String?
    var status:String?
    var sumdeal:String?
    var user_id:String?
    var userId:String?
    var username:String?
    var nickname:String?
    var couponnum:String?
    
    var owner_last_viewtime:String?
    var isalipaysure:Int?
    var isself:Int?
    var isrelation:Int?
    var followNum:Int?


    
    var myOnsaleGoods:[DLMysaleModel]?
    
    
    var shitName:String?{
        get{
            var shit = NSString.numberSuitScanf(self.username)
            shit = NSString.isEmpty(self.nickname) ?
                shit ?? "" :
                self.nickname ?? ""
            return shit
        }
    }
    
}


