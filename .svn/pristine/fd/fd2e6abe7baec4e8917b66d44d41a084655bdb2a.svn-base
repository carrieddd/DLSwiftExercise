//
//  DLInfoNameController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/12.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLInfoNameController: DLBaseViewController {
    
    @IBOutlet weak var nicknameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor
        self.navigationItem.title = "修改昵称"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func configureNickname(_ sender: UIButton) {
    
        guard !NSString.isEmpty(nicknameTF.text) else {
            SVProgressHUD.showInfo(withStatus: "请输入昵称")
            return
        }
        
        DLNewWork.request(url: users_setNickname, method: .post, parameters: ["nickname":nicknameTF.text ?? "","token":DLUserInfo.share.token ?? ""], succeed: { [weak self](result) in
            DLUserInfo.share.userModel?.nickname = self?.nicknameTF.text
            NotificationCenter.default.post(name: N_users_getusermsg, object: nil)
            self?.back()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
}
