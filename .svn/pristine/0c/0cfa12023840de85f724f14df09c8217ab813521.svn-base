//
//  DLProductDetialHead.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLProductDetialHead: UITableViewCell {

    @IBOutlet weak var goodsBriefLbl: UILabel!
    @IBOutlet weak var nowPrice: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var province: UILabel!
    @IBOutlet weak var browseCount: DLDefaultLabel_d1!
    
    func configureData(model:DLGoodsDetailModel) {
        goodsBriefLbl.text = model.goods?.goodsName
        
        nowPrice.text = "¥\(model.goods?.nowPrice ?? "0")"
        let nowPriceString = NSMutableAttributedString.init(string: nowPrice.text!)
        nowPriceString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
        nowPrice.attributedText = nowPriceString
        
        if !NSString.isEmpty(model.goods?.originalPrice) {
            originalPrice.text = "¥\(model.goods?.originalPrice ?? "0")"
            let priceString = NSMutableAttributedString.init(string: originalPrice.text!)
            priceString.addAttributes([NSAttributedStringKey.strikethroughStyle : NSNumber.init(value: 1)], range: NSRange.init(location: 1, length: priceString.length-1))
            originalPrice.attributedText = priceString
        }

        let dateString:String = model.goodsExtray?.ownerLastViewtime ?? ""
        let string = NSString.formattedDate(dateString, style: "yyyy-MM-ddHH:mm:ss")
//        province.text = "\(model.goodsExtray?.province ?? "")   \(string ?? "刚刚")登录过"

        
        var locate = "\(model.goodsExtray?.province ?? "")\(model.goodsExtray?.city ?? "")\(model.goodsExtray?.area ?? "") \(string ?? "刚刚")来过"
        
        if model.goodsExtray?.province ==  model.goodsExtray?.city{
            locate = "\(model.goodsExtray?.province ?? "")\(model.goodsExtray?.area ?? "") \(string ?? "刚刚")来过"
        }
//        city.text =  locate
        province.text = locate

        
        
        
        browseCount.text = "预览\(model.goodsExtray?.browseCount ?? "0")"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
