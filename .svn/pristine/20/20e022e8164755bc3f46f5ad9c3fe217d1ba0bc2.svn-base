//
//  DLPublicHeadView.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/7.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLPublicHeadDelegate {
    func openCamera()
}

class DLPublicHeadView: UIView {
    
    var delegate:DLPublicHeadDelegate?
    var cameraCenter:DLBaseButton?
    var cameraLeft:DLBaseButton?
    var imageScroll:DLImagesScroll?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupUI(){
        cameraCenter = DLBaseButton.init { [weak self]_ in
            self?.delegate?.openCamera()
        }
        cameraCenter!.setImage(UIImage.init(named: "p_camera_c"), for: .normal)
        addSubview(cameraCenter!)
        cameraCenter!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        cameraLeft = DLBaseButton.init { [weak self]_ in
            self?.delegate?.openCamera()
        }
        
        cameraLeft!.backgroundColor = BackGroundColor
        cameraLeft!.setImage(UIImage.init(named: "p_camera_l"), for: .normal)
        addSubview(cameraLeft!)
        cameraLeft!.snp.makeConstraints { (make) in
            make.left.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.width.equalTo(self.snp.height).inset(16)
        }
        cameraLeft?.isHidden = true

        imageScroll = DLImagesScroll.init()
        imageScroll?.imagesStatus = self
        imageScroll?.backgroundColor = UIColor.white
        addSubview(imageScroll!)
        imageScroll!.snp.makeConstraints({ (make) in
            make.left.equalTo(cameraLeft!.snp.right).offset(8)
            make.height.equalTo(self)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        })
        imageScroll?.isHidden = true
        
    }

}

extension DLPublicHeadView:DLImagesScrollDelegate{
    func haveImage() {        
        cameraLeft?.isHidden = false
        imageScroll?.isHidden = false
    }
    
    func imageEmpty() {
        cameraLeft?.isHidden = true
        imageScroll?.isHidden = true
    }
}
