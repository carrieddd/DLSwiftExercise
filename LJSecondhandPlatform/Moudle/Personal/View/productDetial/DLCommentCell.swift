//
//  DLCommentCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLCommentCell: UITableViewCell {

    
    @IBOutlet weak var avater: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var cotent: UILabel!
    @IBOutlet weak var creattime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        ViewRadius(view: avater, radius: 18.5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(model:DLGoodsComment) {
        avater.imageView?.contentMode = .scaleAspectFill
        avater.setImageWith(URL.init(string: model.user?.avatar ?? ""), for: .normal, placeholder: UIImage.init(named: "avater_d"))
        
        let date:TimeInterval = TimeInterval(model.createTime ?? "0") ?? 0
        let string = NSString.formattedTimeInterval(date)
        creattime.text = string
        cotent.text = model.content
        username.text = NSString.isEmpty(model.user?.nickname) ?
        model.user?.username ?? "" :
        model.user?.nickname ?? ""
    }
    
}
