//
//  DLCameraBottomView.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/31.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLCameraToolDelegate {
    func changeCamera(isfront:Bool)
    func takePhoto()
    func openLibrary()
    func next()

}

class DLCameraBottomView: UIView {

    @IBOutlet weak var nextBtn: UIButton!
    var delegate:DLCameraToolDelegate?
    
    @IBAction func next() {
        delegate?.next()
    }
    
    @IBAction func takePhoto() {
        delegate?.takePhoto()
    }
    @IBAction func openLibrary() {
        delegate?.openLibrary()
    }
}
