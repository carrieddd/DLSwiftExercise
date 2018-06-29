//
//  DLImagesScroll.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/31.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
protocol DLImagesScrollDelegate {
    func haveImage()
    func imageEmpty()
}

class DLImagesScroll: DLPageScroll {
    var imagesStatus:DLImagesScrollDelegate?
    typealias animationHandle = ()->Void
    
    private var _imageViews:[DLSelectionImg]!{
        didSet{
            
        }
    }
    var images:[UIImage]!{
        didSet{
            guard oldValue != nil else {
                return
            }
            
            if images.count == 0{
                imagesStatus?.imageEmpty()
            }
            if images.count > 0{
                imagesStatus?.haveImage()
            }
            
            
            self.removeAllSubviews()
            _imageViews.removeAll()
//            var imgMMP:[UIView] = []

            for (index,value) in images.enumerated() {
                
                let imageView = DLSelectionImg.init(image: value, url: nil) {
                    self.images.remove(at:index)
                }
//                let imageView = DLSelectionImg.init(image:value) {
//                    self.images.remove(at: self.images.index(of:value)!)
//                }
                imageView.tag = index
                self.addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.top.bottom.equalToSuperview().offset(12)
//                    make.width.equalToSuperview().offset(12)
//                    make.width.height.equalTo(70)
//
                    make.centerY.equalToSuperview()
                    make.width.equalTo(self.snp.height).offset(-24)
                    
                    if index == 0{
                        make.left.equalToSuperview().offset(12)
                    }
                    else{
                        make.left.equalTo(_imageViews[index - 1].snp.right).offset(8)
                    }
                    if index == images.count - 1{
                        make.right.equalToSuperview().offset(-12)
                    }
                }
                _imageViews.append(imageView)
            }
        }
    }

    var _urls:[String] = []
    
    func addImgUrl(urls:[String]){
        _urls = urls
//        SVProgressHUD.show()
        
//    DispatchQueue.global().
        DispatchQueue.global().async {
            let imgs =  urls.map { (url) -> UIImage? in

                do {
                    let tempUrl = URL.init(string: url)

                    if let u = tempUrl {
                        let data = try Data.init(contentsOf:u)
                        let img = UIImage.init(data: data)
                        return img
                    }
                    print("图片url错误!")
                    return UIImage()

                }
                catch {
                    print("图片url错误!")
                    return UIImage()
                }
            }
            DispatchQueue.main.async {
                self.images = imgs as! [UIImage]
//                SVProgressHUD.dismiss()
            }
        }
    }
    
    override init() {
        super.init()
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _setup() {
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        images = []
        _imageViews = []
    }

}
