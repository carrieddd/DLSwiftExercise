//
//  DLInfoMobileController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/12.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLInfoMobileController: DLBaseViewController {
    
    var type:Int = 0// 0修改手机 1修改密码
    
    @IBOutlet weak var shitLbl0: UILabel!
    @IBOutlet weak var shitLbl1: UILabel!

    @IBOutlet weak var shitTF0: UITextField!
    @IBOutlet weak var shitTF1: UITextField!
    @IBOutlet weak var shitTF2: UITextField!

    init(t:Int) {
        super.init(nibName: "DLInfoMobileController", bundle: nil)
        type = t
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case 0:
            shitLbl0.text = "原手机号："
            shitTF2.placeholder = "请输入新手机号"
            shitLbl1.text = "新手机号："
            self.navigationItem.title = "修改手机号"
            
        case 1:
            shitLbl0.text = "手机号："
            shitLbl1.text = "新密码："
            shitTF2.placeholder = "请输入新密码"
            self.navigationItem.title = "修改密码"

        default: break
            
        }

        shitTF0.text = DLUserInfo.share.userModel?.mobile ?? ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func configure(_ sender: UIButton) {

        
        guard !NSString.isEmpty(shitTF1.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入短信验证码")
            return
        }
        
        guard !NSString.isEmpty(shitTF2.text) else {
            SVProgressHUD.showInfo(withStatus: "内容不能为空")
            return
        }
        
        if type == 0,!NSString.isMobileNumber(shitTF2.text) {
            SVProgressHUD.showInfo(withStatus: "请输入正确手机号")
            return
        }
        
        var url = ""
        var p = ["token":DLUserInfo.share.token ?? ""]
        
        switch type {
        case 0:
            url = users_setPhone
            p["mobile"] = DLUserInfo.share.userModel?.mobile ?? ""
            p["mobile1"] = shitTF2.text ?? ""
            p["code"] = shitTF1.text ?? ""
        case 1:
            url = users_setPwd
            p["username"] = DLUserInfo.share.userModel?.mobile ?? ""
            p["password"] = shitTF2.text ?? ""
            p["code"] = shitTF1.text ?? ""
        default:
            break
        }
        SVProgressHUD.show()
        DLNewWork.request(url: url, method: .post, parameters: p, succeed: { [weak self](result) in
            SVProgressHUD.showSuccess(withStatus: "修改成功请重新登录！")
            DLUserInfo.share.logout(complete: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
//            DLUserInfo.verifyToken()
            }, failure: {
                SVProgressHUD.showInfo(withStatus: $0)
                print($0)
        })
        
        
    }
    
    @IBAction func getMobileCode(_ sender: UIButton) {
        GetMobileCode(shitTF0.text ?? "", sender)
    }

}
