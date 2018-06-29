//
//  DLMyPublicCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/11.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLMyPublicCellDelegate {
    func editcGoods(model:DLMyPublicModel)
    func deleteGoods(model:DLMyPublicModel)
}

class DLMyPublicCell: UITableViewCell {

    @IBOutlet weak var commentCount: UIButton!
    @IBOutlet weak var browseCount: UIButton!
    @IBOutlet weak var favoriteCount: UIButton!
    
    @IBOutlet weak var goods_image: UIImageView!
    @IBOutlet weak var goods_brief: UILabel!
    @IBOutlet weak var shitBtn1: UIButton!
    @IBOutlet weak var shitBtn2: UIButton!
    
    var _model:DLMyPublicModel?
    var delegate:DLMyPublicCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model:DLMyPublicModel){
        _model = model
        goods_image.setImageWith (URL.init(string: model.goods_image ?? ""), placeholder: UIImage.init(named: "placeholder"))
        goods_brief.text = "\(model.goods_name ?? "")\n\(model.goods_brief ?? "")"
        browseCount.setTitle(" \(model.browse_count ?? " 0")", for: .normal)
        favoriteCount.setTitle(" \(model.favorite_count ?? " 0")", for: .normal)
        commentCount.setTitle(" \(model.comment_count ?? " 0")", for: .normal)
    }
    
    @IBAction func editbtnClick() {
        delegate?.editcGoods(model: _model!)
    }
    @IBAction func deletIClick() {
        delegate?.deleteGoods(model: _model!)
    }

}
