//
//  DLPersonalInfoController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
class DLPersonalInfoController: DLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = [["头像","昵称","手机号"],["登录密码"],["我的地址"]]
        Addnotification()

    }

    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "个人信息"
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLDefaultCell")
        tableView.bounces = false
        let logout:DLBaseButton = DLBaseButton.init { (sender) in
            self.back()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
                DLUserInfo.share.logout(complete: nil)
            }
        }
        logout.setTitle("退出登录", for: .normal)
        logout.backgroundColor = UIColor.white
        logout.setTitleColor(TEXTDARK_1, for: .normal)
        self.view.addSubview(logout)
        logout.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
            make.height.equalTo(54)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Addnotification(){
        NotificationCenter.default.rx.notification(N_users_getusermsg).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.tableView.reloadData()
            print("更新userinfo")
        }
    }

}

extension DLPersonalInfoController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("avatar change")
                changeAvatar()
            case 1:
                
                let p = DLInfoNameController.init(nibName: "DLInfoNameController", bundle: nil )
                self.navigationController?.pushViewController(p, animated: true)
            case 2:
                print("mobile change")

                let p = DLInfoMobileController.init(t: 0)
                self.navigationController?.pushViewController(p, animated: true)

                
            default:
                break
            }
            
        case 1:
            print("psd change")
            let p = DLInfoMobileController.init(t: 1)
            self.navigationController?.pushViewController(p, animated: true)

        case 2:
            print("adress")
            guard let adress = systemOption?.address_list else {
                return
            }
            let p = DLWKWebBaseViewController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")")
            self.navigationController?.pushViewController(p, animated: true)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datasource[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DLDefaultCell = tableView.dequeueReusableCell(withIdentifier: "DLDefaultCell") as! DLDefaultCell
        let titles:[String] = datasource[indexPath.section] as! [String]
        cell.labelL.text = titles[indexPath.row]
        cell.imgL.image = UIImage()
        cell.labalLPadding.constant = 12
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.imgR.setImageWith(URL.init(string: DLUserInfo.share.userModel?.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
                ViewRadius(view: cell.imgR, radius: 18)
                cell.imgR.snp.makeConstraints { (make) in
                    make.height.width.equalTo(36)
                }
                
            case 1:
                cell.labelR.text = DLUserInfo.share.userModel?.nickname ?? ""
            case 2:
                cell.labelR.text = DLUserInfo.share.userModel?.mobile ?? ""
            default:
                break
            }
            
        case 1:
            cell.labelR.text = "修改"
        default:
            break
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 11
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

extension DLPersonalInfoController:TZImagePickerControllerDelegate{
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
    
        uploadImg(imgs: photos) { [weak self](key1, key2) in
            self?.uploadAvatar(key: key1)
            DLUserInfo.share.userModel?.avatar = key1
        }
    }

    
    func changeAvatar(){
        let ablum = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        ablum?.allowPickingVideo = false
        ablum?.allowPickingGif = false
        ablum?.allowTakePicture = true
        ablum?.allowPreview = true
        ablum?.statusBarStyle = .default
        ablum?.showSelectBtn  = true
        ablum?.naviBgColor = NAVBGCOLOR
        ablum?.naviTitleColor = NAVTITLECOLOR
        ablum?.barItemTextColor = NAVTITLECOLOR
        self.present(ablum!, animated: true, completion: nil)
    }
    
    func uploadAvatar(key:String) {
        let p:[String:String] = ["headImg":key ,"token":DLUserInfo.share.token ?? ""]
        DLNewWork.request(url: users_setHeadImg,method:.post, parameters: p, succeed: { (result) in
            SVProgressHUD.showSuccess(withStatus: "头像设置成功！")
            NotificationCenter.default.post(name: N_users_getusermsg, object: nil)
        }, failure: {
            print($0)
            SVProgressHUD.showInfo(withStatus: $0)
        })
    }
}
