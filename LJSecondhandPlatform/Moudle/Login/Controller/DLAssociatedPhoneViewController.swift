//
//  DLAssociatedPhoneViewController.swift
//  LJGeographyFinance
//
//  Created by dongl on 2018/2/6.
//  Copyright © 2018年 dongl. All rights reserved.
//

import UIKit

class DLAssociatedPhoneViewController: DLBaseViewController {
    var resp:UMSocialUserInfoResponse?
    
    var type:Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var protocalBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关联手机号"
        phoneNumberTF.keyboardType = .numberPad
        self.titleLabel.text = "Hi,\(resp?.name ?? "")"
        let attribu = NSMutableAttributedString(string: "点击完成代表同意《注册服务协议》")
        attribu.addAttribute(.foregroundColor, value: UIColor.withHex(hexString: "FB5E2B"), range: NSMakeRange(8, 8))

        protocalBtn.setAttributedTitle(attribu, for: .normal)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func protocalAction(_ sender: Any) {
        let agreement = systemOption?.user_agreement
        self.navigationController?.pushViewController(DLWKWebBaseViewController.init(urlStr: "\(BaseURL)\(agreement ?? "")"), animated: true)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        if !NSString.isMobileNumber(phoneNumberTF.text) {
            SVProgressHUD.showInfo(withStatus: "请输入手机正确号")
            return
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class DLAssociatedPhoneViewController2: DLBaseViewController {
    var resp:UMSocialUserInfoResponse?
    var type:Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var protocalBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关联手机号"
        phoneNumberTF.keyboardType = .numberPad
        self.titleLabel.text = "Hi,\(resp?.name ?? "")"
        let attribu = NSMutableAttributedString(string: "点击完成代表同意《注册服务协议》")
        attribu.addAttribute(.foregroundColor, value: UIColor.withHex(hexString: "FB5E2B"), range: NSMakeRange(8, 8))
        
        protocalBtn.setAttributedTitle(attribu, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func protocalAction(_ sender: Any) {
        let agreement = systemOption?.user_agreement
        self.navigationController?.pushViewController(DLWKWebBaseViewController.init(urlStr: "\(BaseURL)\(agreement ?? "")"), animated: true)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        if !NSString.isMobileNumber(phoneNumberTF.text) {
            SVProgressHUD.showInfo(withStatus: "请输入手机正确号")
            return
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
