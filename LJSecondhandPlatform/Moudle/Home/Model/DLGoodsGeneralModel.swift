//
//  DLGoodsDetailModel.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/5.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import HandyJSON

//这些有什么卵用我也不知道。
struct DLGDUser: HandyJSON {
    var goodsId:String?
    var mobile:String?
    var userId:String?
    var email:String?
    var username:String?
    var avatar:String?
    var nickname:String?

}

class DLGoodsComment: HandyJSON {
    required init() {
    }
    var content:String?
    var createTime:String?
    var goodsId:String?
    var id:String?
    var userId:String?
    var user:DLGoodsOwner?
    var commentHeight:CGFloat?
    func caculateHeight(){
        let contentH = content?.DL_heightForComment(font: UIFont.init(name: "PingFangSC-Regular", size: 14)!, width: dScreenW - 57 - 12) // 57左边距 12右边距
        commentHeight = (contentH ?? 0) + 50 + 40 //50上边距 40下边距
    }
}

struct DLGoodsExtray: HandyJSON {
    var goodsId:String?
    var userId:String?
    var status:String?
    var buyerId:String?
    var province:String?
    var city:String?
    var area:String?
    var locationX:String?
    var locationY:String?
    var commentCount:String?
    var browseCount:String?
    var favoriteCount:String?
    var ownerLastViewtime:String?
}
struct DLUserAccount: HandyJSON {
    var userId:String?
    var balance:String?
    var points:String?
    var exp:String?
    var onsalegoods:String?
    var sumdeal:String?
}

struct DLGoodsFavorite: HandyJSON {
}


struct DLGoodsCount: HandyJSON {
    var goodsId:String?
    var userId:String?
    var status:String?
    var buyerId:String?
    var province:String?
    var city:String?
    var area:String?
    var locationX:String?
    var locationY:String?
    var commentCount:String?
    var browseCount:String?
    var favoriteCount:String?
    var ownerLastViewtime:String?
}

class DLGoodsAlbum: HandyJSON {
    required init() {
    }
    var id:String?
    var goodsId:String?
    var image:String?
    var imgSize:CGSize? = CGSize.init(width: 1, height: 1)
    func caculateSize() {
        imgSize = UIImage.getSizeWithURL(image)
    }
}

struct DLGoods: HandyJSON {
    var cateId:String?
    var goodsId:String?
    var brandId:String?
    var goodsName:String?
    var goodsSn:String?
    var nowPrice:String?
    var originalPrice:String?
    var goodsImage:String?
    var goodsBrief:String?
    var goodsContent:String?
    var goodsWeight:String?
    var stockQty:String?
    var metaKeywords:String?
    var metaDescription:String?
    var createdDate:String?
    var newarrival:String?
    var recommend:String?
    var bargain :String?
    var status:String?
    var integral:String?
    var rebateIntegral:String?
}

struct DLGoodsOwner: HandyJSON {
    var userId:String?
    var username:String?
    var password:String?
    var email:String?
    var mobile:String?
    var avatar:String?
    var nickname:String?
    var status:String?
    var emailStatus:String?
    var mobileStatus:String?
    var token:String?
    var createTime:String?
    var upateTime:String?
    var jpushId:String?
}


