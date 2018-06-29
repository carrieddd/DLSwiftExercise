//
//  DLMbLoginController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/30.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLMbLoginController: DLBaseViewController {

    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "快速登录"
    }

    @IBAction func mbLogin() {
        guard NSString.isMobileNumber(mobileTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            return
        }
        guard !NSString.isEmpty(codeTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入密码")
            return
        }
        
        let parameters = [
            "mobile":mobileTF.text ?? "",
            "code":codeTF.text ?? ""] as [String : Any]
        
        DLNewWork.request(url: users_loginByMobile,method:.get, parameters: parameters, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            DLUserInfo.share.token = dict["datas"] as? String ?? ""
            self.dismiss(animated: true, completion: nil)
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
    
    @IBAction func forgetPsd() {
        let v = DLForgetPsdController.init(nibName: "DLForgetPsdController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
    @IBAction func register() {
        let v = DLRegisterController.init(nibName: "DLRegisterController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }

    @IBAction func getMobileCode(_ sender: UIButton) {
        GetMobileCode(mobileTF.text ?? "", sender)
    }
}
