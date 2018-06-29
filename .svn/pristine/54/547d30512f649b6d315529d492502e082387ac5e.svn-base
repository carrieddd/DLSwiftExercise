//
//  DLMySaleBaseCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLMySaleBaseCellDelegate {
    func chickButtonAction(model:DLMysaleModel)
}

class DLMySaleBaseCell: UITableViewCell {

    var delegate:DLMySaleBaseCellDelegate?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var goods_brief: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var goods_image: UIImageView!
    @IBOutlet weak var now_price: UILabel!
    @IBOutlet weak var chickItem: UIButton!
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    private var _model:DLMysaleModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewRadius(view: avatar, radius: 12)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureData(model:DLMysaleModel){
        _model = model
        avatar.setImageWith(URL.init(string: model.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
        goods_image.setImageWith(URL.init(string: model.goods_image ?? ""), placeholder: UIImage.init(named: "placeholder"))
        ViewBoardRadius(view: goods_image, radius: 3, width: 1, color: LINECOLOR)
        nickname.text = NSString.isEmpty(model.nickname) ?
            model.username ?? "" :
            model.nickname ?? ""
        goods_brief.text = "\(model.goods_name ?? "")\n\(model.goods_brief ?? "")"
        now_price.text = "¥\(model.now_price ?? "0")"
        let nowPriceString = NSMutableAttributedString.init(string: now_price.text!)
        nowPriceString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
        now_price.attributedText = nowPriceString
        bottomHeight.constant = model.havAction == true ? 54:0
        
        switch Int(model.order_status ?? "0"){
        case 1:
            status.text = " 等待买家付款 "
            chickItem.setTitle(" 确认付款 ", for: .normal)
        case 2:
            status.text = " 等待卖家发货 "
            chickItem.setTitle(" 确认发货 ", for: .normal)
        case 3:
            status.text = " 等待买家收货 "
            chickItem.setTitle(" 确认收货 ", for: .normal)
        case 4:
            status.text = " 待评价 "
        case 5:
            status.text = ""

        default:
            break
        }
    }
    
    @IBAction func chickButtonAction(_ sender: UIButton) {
        self.delegate?.chickButtonAction(model:_model!)
    }
}
