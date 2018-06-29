//
//  DLMyPublicList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/11.
//  Copyright © 2018年 iOS110. All rights reserved.
//
import CRRefresh
import SDCAlertView
class DLMyPublicList: DLBaseTableViewController {
    
    var type:String!
    init(t:String) {
        super.init(tableStyle: .grouped)
        self.type = t
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cr.beginHeaderRefresh()
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLMyPublicCell")
        tableView.cr.addHeadRefresh(animator:FastAnimator()) { [weak self] in
            self?.request {
                self?.tableView.cr.endHeaderRefresh()
                self?.tableView.cr.resetNoMore()
            }
        }
        NotificationCenter.default.rx.notification(N_goodslist_upload).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.tableView.cr.beginHeaderRefresh()
            print("更新goodslist")
        }
        NotificationCenter.default.rx.notification(N_users_publicGoods).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.tableView.cr.beginHeaderRefresh()
            print("更新goodslist")
        }


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DLMyPublicList:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DLMyPublicCell = tableView.dequeueReusableCell(withIdentifier: "DLMyPublicCell") as!DLMyPublicCell
        cell.configure(model: datasource[indexPath.section] as! DLMyPublicModel)
        
        cell.shitBtn1.setTitle( self.type == "1" ? "下架":"编辑" , for: .normal)
        cell.shitBtn2.isHidden = self.type == "1"
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 11
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let v = DLProductDetialController(nibName: "DLProductDetialController", bundle: nil, tableStyle:.grouped)
        let model = datasource[indexPath.section] as! DLMyPublicModel
        let v = DLProductDetialController.init(id:model.goods_id ?? "")
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)
    }
}

let N_goodslist_upload = NSNotification.Name(rawValue:"users_goodslist_notification")

extension DLMyPublicList:DLMyPublicCellDelegate {
    func deleteGoods(model: DLMyPublicModel) {
        let alert = AlertController(title: "\(model.goods_name ?? "")确认从草稿箱删除？", message: "从草稿箱删除将无法恢复", preferredStyle: .alert)
        let cancelAction = AlertAction(title: "取消", style: .destructive) { (action) in
            alert.dismiss()
        }
        let action = AlertAction(title: "确认", style: .normal, handler: { [weak self](action) in
            self?.requestDele(type: "0", goodId: model.goods_id ?? "") {
                NotificationCenter.default.post(name: N_goodslist_upload, object: nil)
            }
        })
        alert.addAction(cancelAction)
        alert.addAction(action)
        alert.present()
    }
    
    func editcGoods(model: DLMyPublicModel) {
        if self.type == "1"{
            let alert = AlertController(title: "\(model.goods_name ?? "")确认下架？", message: nil, preferredStyle: .alert)
            let cancelAction = AlertAction(title: "取消", style: .destructive) { (action) in
                alert.dismiss()
            }
            let action = AlertAction(title: "确认", style: .normal, handler: { [weak self](action) in
                self?.requestDele(type: "1", goodId: model.goods_id ?? "") {
                        NotificationCenter.default.post(name: N_goodslist_upload, object: nil)
                }
            })
            alert.addAction(cancelAction)
            alert.addAction(action)
            alert.present()
        }
        else
        {
            let v = DLPublicController.init { (v) in
                v.originalPrice.text = model.original_price ?? ""
                v.nowPriceTF.text = model.now_price ?? ""
                v.goodsNameTF.text = model.goods_name ?? ""
                v.goodsContentTF.text = model.goods_brief ?? ""
                v.request(goodId:model.goods_id ?? "" )
                v.goodId = model.goods_id
                v.catId = model.cate_id ?? ""
                v.catButton.setTitle(model.cate_name ?? "", for: .normal)
            }
            self.navigationController?.pushViewController(v, animated: true)
        }
        
    }
    
    func request(handle:(()->Void)?){
        
        let p = [
            "goodstatus":self.type ?? "1",
            "token":DLUserInfo.share.token ?? "",
            "page":"1",
            "rows":"999"]
        
        DLNewWork.request(url: users_getmypublishgoods,method:.get, parameters: p, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self.datasource = datas.map{DLMyPublicModel.deserialize(from:$0)!}
            self.tableView.reloadData()
            handle?()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
            handle?()
        })
    }
    
    func requestDele(type:String ,goodId:String,complete:(()->Void)?){
        let parameters = ["type":type ,"token":DLUserInfo.share.token ?? "","ids":goodId]
        DLNewWork.request(url:shop_delePreGood,method:.delete, parameters: parameters, succeed: { (result) in
            complete?()
        }, failure: {
            print($0)
            complete?()
        })
    }
}

