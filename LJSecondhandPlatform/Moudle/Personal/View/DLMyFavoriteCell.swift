//
//  DLMyFavoriteCell.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/11.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol contentImageClickDelegate {
    func scrollClick(goodId:String)
    func avaterClick(userId:String)
}

class DLMyFavoriteCell: UITableViewCell {

    var clickDelegate:contentImageClickDelegate?
    @IBOutlet weak var contentBGView: UIView!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var nowPrice: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var avater_btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var _model:DLMyFavoriteModel?
    
    @IBAction func avatarClick() {
        clickDelegate?.avaterClick(userId: _model?.userId ?? "")
    }

    //真的很傻逼很傻逼的。一样的UI 给我两套接口两套模型映射
    func configureShitFavorite(favoriteShit:DLMyFavoriteModel) {
        _model = favoriteShit
        ViewRadius(view: avater_btn, radius: 20)
        let imgGroup = favoriteShit.albums?.components(separatedBy: ",")
        contentImgView_typeMore(imges: imgGroup ?? [])
        nicknameLbl.text = NSString.isEmpty(favoriteShit.nickname) ?
            favoriteShit.username ?? "" :
            favoriteShit.nickname ?? ""
        avater_btn.setImageWith(URL.init(string: favoriteShit.avatar ?? ""), for: .normal, placeholder: UIImage.init(named: "avater_d"))
        let dateString:String = favoriteShit.create_time ?? ""
        let string = NSString.formattedDate(dateString, style: "yyyy-MM-ddHH:mm:ss")
//        city.text = "\(favoriteShit.province ?? "")     \(string ?? "刚刚")来过"        
        
        var locate = "\(favoriteShit.province ?? "")\(favoriteShit.city ?? "")\(favoriteShit.area ?? "") \(string ?? "刚刚")来过"
        if favoriteShit.province ==  favoriteShit.city{
            locate = "\(favoriteShit.province ?? "")\(favoriteShit.area ?? "") \(string ?? "刚刚")来过"
        }
        city.text =  locate

        
        originalPrice.text = "¥\(favoriteShit.original_price ?? "0")"
        let priceString = NSMutableAttributedString.init(string: originalPrice.text!)
        priceString.addAttributes([NSAttributedStringKey.strikethroughStyle : NSNumber.init(value: 1)], range: NSRange.init(location: 1, length: priceString.length-1))
        originalPrice.attributedText = priceString
        
        nowPrice.text = "¥\(favoriteShit.now_price ?? "0")"
        let nowPriceString = NSMutableAttributedString.init(string: nowPrice.text!)
        nowPriceString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
        nowPrice.attributedText = nowPriceString
        goodsName.text = "\(favoriteShit.goods_name ?? "")"
    }

    func contentImgView_typeMore(imges:[String]) {
        
        guard imges.count > 0 else {
            return
        }
        
        let scroll = DLClickScroll.init()
        scroll.backgroundColor = UIColor.white
        self.contentBGView.addSubview(scroll)
        scroll.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scroll.clickDelegate = self

        var imgMMP:[UIView] = []
        
        for (index,value) in imges.enumerated() {
            let image = shitImageView.init(url:value)
            scroll.addSubview(image)
            
            image.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.height.equalTo(scroll.snp.height)
                make.width.equalTo(scroll.snp.height)
                
                if index == 0{
                    make.left.equalToSuperview()
                }
                else{
                    make.left.equalTo(imgMMP[index - 1].snp.right).offset(8)
                }
                
                if index == imges.count - 1{
                    make.right.equalToSuperview().offset(-12)
                }
            }
            imgMMP.append(image)
        }
    }
}

extension DLMyFavoriteCell:scrollClickDelegate{
    func scrollClick() {
        self.clickDelegate?.scrollClick(goodId: _model?.goods_id ?? "")
    }
}