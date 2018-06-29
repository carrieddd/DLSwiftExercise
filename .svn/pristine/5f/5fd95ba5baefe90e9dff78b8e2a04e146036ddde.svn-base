//
//  DLRegisterController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/30.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLRegisterController: DLBaseViewController {

    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var psdTF: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "注册"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login() {
        
        guard NSString.isMobileNumber(mobileTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            return
        }
        
        guard !NSString.isEmpty(codeTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入短信验证码")
            return
        }

        guard !NSString.isEmpty(psdTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入密码")
            return
        }

        
        let parameters = [
            "username":mobileTF.text ?? "",
            "password":psdTF.text ?? "",
            "code":codeTF.text ?? ""] as [String : Any]

        DLNewWork.request(url: users_register,method:.post, parameters: parameters, succeed: { (result) in

            SVProgressHUD.showSuccess(withStatus: "注册成功！")
            self.back()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
        
    }
    
    @IBAction func mobileLogin(_ sender: Any) {
        let v = DLLoginController.init(nibName: "DLLoginController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @IBAction func getMobileCode(_ sender: UIButton) {
        GetMobileCode(mobileTF.text ?? "", sender)
    }
    
}
