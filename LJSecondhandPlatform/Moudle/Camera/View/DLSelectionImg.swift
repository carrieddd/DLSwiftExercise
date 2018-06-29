//
//  DLSelectionImg.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/31.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit


class DLSelectionImg: UIView {
    
    typealias DeleteHandle = ()->Void
    
    
    init(image: UIImage?,url:String?,delete:(()->Void)?) {
        super.init(frame: .zero)
        
        let imageView = UIImageView.init()
        imageView.setImageWith(URL.init(string: url ?? ""), placeholder: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        self.backgroundColor = UIColor.white
//        imageView.isUserInteractionEnabled = true
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let deleteBtn = DLBaseButton.init { [weak self](sender) in
            delete?()
        }
        self.addSubview(deleteBtn)
        deleteBtn.setImage(UIImage.init(named: "X_red"), for: .normal)
        deleteBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(-10)
            make.width.height.equalTo(35)
        }

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
