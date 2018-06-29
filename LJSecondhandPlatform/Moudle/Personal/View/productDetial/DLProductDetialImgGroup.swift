//
//  DLProductDetialImgGroup.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLProductDetialImgGroup: UITableViewCell {

    @IBOutlet weak var goodsBriefLbl: UILabel!
    var images:[UIImageView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureData(model:DLGoodsDetailModel) {
        images.forEach{$0.removeFromSuperview()}
        images.removeAll()
        goodsBriefLbl.text = model.goods?.goodsBrief
        model.goodsAlbum?.forEach{
            let image = shitImageView.init(url: $0.image ?? "")
            self.addSubview(image)
            images.append(image)
        }
        for (index,view) in images.enumerated() {
            view.snp.makeConstraints { (make) in
                make.left.equalTo(12)
                make.right.equalTo(-12)

                let size = model.goodsAlbum![index].imgSize ?? .zero
                let rate:CGFloat = size.height / size.width
                make.height.equalTo(rate * (dScreenW - 24))

                if index == 0 {
                    make.top.equalTo(goodsBriefLbl.snp.bottom).offset(12)
                }else{
                    make.top.equalTo(images[index - 1].snp.bottom).offset(12)
                }
            }
        }
    }
    
    func configureImgs(images:[UIImageView]) {
        for (index,view) in images.enumerated() {
            view.snp.makeConstraints { (make) in
                make.left.equalTo(12)
                make.right.equalTo(-12)
                let size = view.size
                let rate:CGFloat = size.height / size.width
                make.height.equalTo(rate * (dScreenW - 24))
                
                if index == 0 {
                    make.top.equalTo(goodsBriefLbl.snp.bottom).offset(12)
                }else{
                    make.top.equalTo(images[index - 1].snp.bottom).offset(12)
                }
            }
        }
    }
}
