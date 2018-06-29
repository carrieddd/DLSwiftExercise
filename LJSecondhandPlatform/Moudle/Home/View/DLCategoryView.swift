//
//  DLCategoryView.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/5.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLCategoryViewDelegate {
    func chooseCat(category:DLCategoryModel)
}

class DLCategoryView: UIView {

    private var items:[UIView] = []
    var delegate:DLCategoryViewDelegate?
    var _categorys:[DLCategoryModel]?
    static let vHight:CGFloat = 88.0
    static let widthCount:CGFloat = 4.0
    
    init(item:[DLCategoryModel],frame:CGRect) {
        super.init(frame:frame)
        _categorys = item
        self.backgroundColor = UIColor.white
        guard item.count > 0 else {
            return
        }
        for (index,value) in item.enumerated() {
            let item = Bundle.main.loadNibNamed("DLCategoryItem", owner: nil, options: nil)?.first as!  DLCategoryItem
            item.backgroundColor = .white
            self.addSubview(item)
            item.imgBtn.setImageWith(URL.init(string: value.cateImage ?? ""), for: .normal, placeholder: UIImage.init(named: "catPlaceholder"))

            item.imgBtn.addTarget(self, action: #selector(_click), for: .touchUpInside)
            item.imgBtn.tag = index
            item.nameLbl.text = value.cateName ?? ""
            items.append(item)
        }
        
        for (index,value) in items.enumerated() {
            value.size = CGSize.init(width: self.width/DLCategoryView.widthCount, height: DLCategoryView.vHight)
            let rows:Int = Int(floor(Double(index)/Double(DLCategoryView.widthCount)))
            value.top = CGFloat(rows) * DLCategoryView.vHight
            value.left = CGFloat(index).truncatingRemainder(dividingBy: DLCategoryView.widthCount) * value.width
        }
        
        let bottom:CALayer = CALayer.init()
        bottom.backgroundColor = BackGroundColor.cgColor
        self.layer.addSublayer(bottom)
        bottom.frame = CGRect.init(x: 0, y: height - 12, width: width, height: 12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func _click(sender:UIButton) {
        delegate?.chooseCat(category: _categorys![sender.tag])
    }


}
