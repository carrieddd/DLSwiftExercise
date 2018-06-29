//
//  DLUserCardCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLUserCardCell: UITableViewCell {

    @IBOutlet weak var avater: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ownerLastViewtime: UILabel!
    @IBOutlet weak var onsalegoods: UILabel!
    @IBOutlet weak var sumdeal: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var relationBtn: DLRelationShipButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureData(model:DLGoodsDetailModel) {
        let shit2 = NSString.numberSuitScanf(model.userInfo?.username)
        userName.text = NSString.isEmpty(model.userInfo?.nickname) ?
            shit2 ?? "" :
            model.userInfo?.nickname ?? ""
        ViewRadius(view: avater, radius: 18)
        avater.setImageWith(URL.init(string: model.userInfo?.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
        
        let dateString:String = model.goodsExtray?.ownerLastViewtime ?? ""
        let string = NSString.formattedDate(dateString, style: "yyyy-MM-ddHH:mm:ss")
        ownerLastViewtime.text = "\(string ?? "刚刚")来过"
        onsalegoods.text = model.userAccount?.onsalegoods ?? "0"
        sumdeal.text = model.userAccount?.sumdeal ?? "0"
        points.text = model.userAccount?.points ?? "0"
        relationBtn.bindUserId = model.userInfo?.userId

    }
}