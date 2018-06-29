//
//  DLLoginController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/30.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLLoginController: DLBaseViewController {

    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var psdTF: UITextField!
    
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
        let backBtn:DLBaseButton = DLBaseButton.init { [weak self](sender) in
            self?.back()
        }
        backBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backBtn.contentHorizontalAlignment = .left
        backBtn.setImage(UIImage.init(named:"back_X"), for: .normal)
        backItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.title = "登录"
    }

    @IBAction func login() {
        guard NSString.isMobileNumber(mobileTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            return
        }
                
        guard !NSString.isEmpty(psdTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入密码")
            return
        }
        
        let parameters = [
            "mobile":mobileTF.text ?? "",
            "password":psdTF.text ?? ""] as [String : Any]
        
        DLNewWork.request(url: users_login,method:.get, parameters: parameters, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            DLUserInfo.share.token = dict["datas"] as? String ?? ""
            self.dismiss(animated: true, completion: nil)
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })}
    
    @IBAction func mobileLogin(_ sender: Any) {
        let v = DLMbLoginController.init(nibName: "DLMbLoginController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @IBAction func forgetPsd() {
        let v = DLForgetPsdController.init(nibName: "DLForgetPsdController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @IBAction func register() {
        let v = DLRegisterController.init(nibName: "DLRegisterController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }

    @IBAction func qqwxLogin(_ sender: UIButton) {
//        SVProgressHUD.show()
        UMSocialManager.default().getUserInfo(with: UMSocialPlatformType(rawValue: sender.tag)!, currentViewController: nil, completion: { (result, userError) in
//            SVProgressHUD.dismiss()
            if result != nil{
                let resp:UMSocialUserInfoResponse = result as! UMSocialUserInfoResponse
                print(resp.name)
                print(resp.iconurl)
                self.wechatOrQQLogRequest(sender.tag, resp: resp)
            }else{
                debugPrint("--",userError.debugDescription)
            }
        })
    }
    
    private func wechatOrQQLogRequest(_ type:Int,resp:UMSocialUserInfoResponse){
        var param = [String:String]()
        if type == 1 {
            param = ["keyId":resp.unionId,"method":"2"]
        }else{
            param = ["keyId":resp.openid,"method":"1"]
        }
        DLNewWork.request(url: users_wxqqlogin, method: .get, parameters: param, succeed: { (response) in
            
            let dict:[String:Any] = response as! Dictionary
            let datas:[String:Any] = dict["datas"] as! [String : Any]
            let isbind:String = "\(datas["isbind"] ?? "")"
            if isbind == "0"{
                let v = DLAssociatedPhoneViewController()
                v.resp = resp
                v.type = type
                self.navigationController?.pushViewController(v, animated: true)
            }
            
        }) { (errorStr) in
            SVProgressHUD.showInfo(withStatus: errorStr)
        }
    }
}
