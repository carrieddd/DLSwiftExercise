//
//  DLGoodsCollectionCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/22.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLGoodsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var orangePrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureData(model:DLMysaleModel){

        goodImage.setImageWith(URL.init(string: model.goods_image ?? ""), placeholder: UIImage.init(named: "placeholder"))
        goodName.text = "\(model.goods_name ?? ""))"
        goodPrice.text = "¥\(model.now_price ?? "0")"
        let nowPriceString = NSMutableAttributedString.init(string: goodPrice.text!)
        nowPriceString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
        goodPrice.attributedText = nowPriceString

        orangePrice.text = "¥\(model.original_price ?? "0")"
        let priceString = NSMutableAttributedString.init(string: orangePrice.text!)
        priceString.addAttributes([NSAttributedStringKey.strikethroughStyle : NSNumber.init(value: 1)], range: NSRange.init(location: 0, length: priceString.length))
        orangePrice.attributedText = priceString

        let date:TimeInterval = TimeInterval(model.created_date ?? "0") ?? 0
        let string = NSString.formattedTimeInterval(date)
        time.text = "\(string ?? "刚刚")发布"
        
        var locate = "\(model.province ?? "")\(model.city ?? "")\(model.area ?? "")"
        if model.province ==  model.city{
            locate = "\(model.province ?? "")\(model.area ?? "")"
        }
        city.text =  locate
    }

}
