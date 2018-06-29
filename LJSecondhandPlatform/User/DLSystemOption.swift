//
//  DLSystemOption.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/14.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import HandyJSON

var systemOption:DLSystemShit?
struct DLSystemShit: HandyJSON {
    var address_add:String? = "http://192.168.1.106:28234/fish/index.html#/addaddress"
    var address_edit:String? = "http://192.168.1.106:28234/fish/index.html#/editaddres"
    var address_list:String? = "http://192.168.1.106:28234/fish/index.html#/address"
    var alipay_info:String? = "http://192.168.1.106:28234/fish/index.html#/setali"
    var order_submit:String? = "http://192.168.1.106:28234/fish/index.html#/goodorder"
    var order_detail:String? = "http://192.168.1.106:28234/fish/index.html#orderdetail"
    var order_pay:String? = "http://192.168.1.106:28234/fish/index.html#orderpay"
    var pay_success:String? = "http://192.168.1.106:28234/fish/index.html#/Success"
    var user_balance:String? = "http://192.168.1.106:28234/fish/app/user_balance.html"
    var invite_register:String? = "http://www.moread.com/fish/index.html#/invitation"
    var invite_friend:String? = "http://www.moread.com/fish/index.html#/invite"
    var user_coupon:String? = "http://192.168.1.106:28234/fish/index.html#/coupon"
    var coupon_event:String? = "http://192.168.1.106:28234/fish/index.html#/ticketTask"
    var user_agreement:String? = "http://192.168.1.106:28234/fish/index.html#/agreement"

}