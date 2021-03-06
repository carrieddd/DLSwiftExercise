//
//  DLPersonalHead.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLPersonalHeadDelegate {
    func avaterClick()
    func turnMoney()
    func turnPoint()
    func turnVerify()
    func turnCoupon()

}


class DLPersonalHead: UIView {
    @IBOutlet weak var avater: UIButton!

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!

    @IBOutlet weak var couponLbl: DLDefaultLabel_h2!
    @IBOutlet weak var statusLbl: DLDefaultLabel_h1!
    @IBOutlet weak var statusBtn: DLVerifyBtn!
    var delegate:DLPersonalHeadDelegate?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        ViewRadius(view: avater, radius: 30)
        avater.imageView?.contentMode = .scaleAspectFill
    }


    @IBAction func avaterClick() {
        self.delegate?.avaterClick()
    }
    @IBAction func turnMoney() {
        self.delegate?.turnMoney()
    }
    @IBAction func turnPoint() {
        self.delegate?.turnPoint()
    }
    @IBAction func turnVerify() {
        self.delegate?.turnVerify()
    }
    @IBAction func turnCoupon() {
        self.delegate?.turnCoupon()
    }

}
