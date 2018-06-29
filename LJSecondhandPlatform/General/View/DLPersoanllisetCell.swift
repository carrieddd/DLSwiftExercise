//
//  DLPersoanllisetCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/27.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLPersoanllisetCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var followNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewRadius(view: avatar, radius: 25)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configure(model:DLUserModel){
        let shit2 = NSString.numberSuitScanf(model.username) ?? ""
        nickName.text = NSString.isEmpty(model.nickname) ?
            shit2 :
            model.nickname ?? ""
        avatar.setImageWith(URL.init(string: model.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
        followNum.text = "\(model.followNum ?? 0)人关注Ta"
    }
}
