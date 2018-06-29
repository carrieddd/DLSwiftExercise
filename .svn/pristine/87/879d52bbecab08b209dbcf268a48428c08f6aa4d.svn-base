
//
//  DLGoodsUserCard.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/26.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol UsercardDelegate {
    func turnController(index:Int)
}

class DLGoodsUserCard: UICollectionReusableView {
    
    var delegate:UsercardDelegate?
    
    @IBOutlet weak var backItem: UIButton!
    @IBOutlet weak var contentBg: UIView!
    @IBOutlet weak var avater: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ownerLastViewtime: UILabel!
    @IBOutlet weak var relations: UILabel!
    @IBOutlet weak var fans: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var relationBtn: DLRelationShipButton!
    
    override func awakeFromNib() {
        contentBg.layer.shadowColor = UIColor.lightGray.cgColor
        contentBg.layer.shadowOpacity = 1.0
        contentBg.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentBg.clipsToBounds = false
        contentBg.layer.cornerRadius = 25.0
        
    }

    
    func configureData(model:DLUserModel) {
        
        let shit2 = NSString.numberSuitScanf(model.username)
        userName.text = NSString.isEmpty(model.nickname) ?
            shit2 ?? "" :
            model.nickname ?? ""
        ViewRadius(view: avater, radius: 18)
        avater.setImageWith(URL.init(string: model.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
        let dateString:String = model.owner_last_viewtime ?? ""
        let string = NSString.formattedDate(dateString, style: "yyyy-MM-ddHH:mm:ss")
        ownerLastViewtime.text = "\(string ?? "刚刚")来过"
        relations.text = "\(model.myRelations ?? 0)"
        fans.text = "\(model.myFans ?? 0)"
        points.text = "\(model.points ?? "0")"
        relationBtn.bindUserId = model.user_id
        relationBtn.isHidden = model.isself == 1
        relationBtn.isSelected = model.isrelation == 1
    }
    
    @IBAction func turnFans() {
        delegate?.turnController(index: 0)
    }
    @IBAction func turnFollow() {
        delegate?.turnController(index: 1)
    }
    @IBAction func turnPoint() {
        delegate?.turnController(index: 2)
    }

}
