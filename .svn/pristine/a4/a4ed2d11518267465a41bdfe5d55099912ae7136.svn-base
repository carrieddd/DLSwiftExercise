//
//  DLMyFavoriteList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/11.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import CRRefresh

class DLMyFavoriteList: DLBaseTableViewController {
    var cur = 1
    var status:String?
    
    init(status:String) {
        super.init(tableStyle: .grouped)
        self.status = status
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
        tableView.registerNib(nibName: "DLMyFavoriteCell")
        
        tableView.cr.addHeadRefresh(animator:FastAnimator()) { [weak self] in
            self?.request {
                self?.tableView.cr.endHeaderRefresh()
                self?.tableView.cr.resetNoMore()
            }
        }
        
//        tableView.cr.addFootRefresh(animator:NormalFooterAnimator()) { [weak self] in
////            self?.cur ++
//            self?.request {
//                self?.tableView.cr.endLoadingMore()
//            }
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DLMyFavoriteList:contentImageClickDelegate{
    func avaterClick(userId: String) {
        let v = DLlPersonalGoodsGrid.init(userId: userId)
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)
    }
    

    func scrollClick(goodId:String) {
        let v = DLProductDetialController.init(id:goodId)
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)
    }
}

extension DLMyFavoriteList:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DLMyFavoriteCell = tableView.dequeueReusableCell(withIdentifier: "DLMyFavoriteCell") as!DLMyFavoriteCell
        cell.configureShitFavorite(favoriteShit: datasource[indexPath.section] as! DLMyFavoriteModel)
        cell.clickDelegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let v = DLProductDetialController(nibName: "DLProductDetialController", bundle: nil, tableStyle:.grouped)
        let model = datasource[indexPath.row] as! DLMyFavoriteModel
        let v = DLProductDetialController.init(id:model.goods_id ?? "")
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return status == "2" ? 265-44:265
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 11
    }
    
}

extension DLMyFavoriteList {
    func request(handle:(()->Void)?){

        let p = [
            "status":status ?? "0",
            "token":DLUserInfo.share.token ?? ""]

        DLNewWork.request(url: shop_getGoodsFavorite,method:.get, parameters: p, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self.datasource = datas.map{DLMyFavoriteModel.deserialize(from:$0)!}
            self.tableView.reloadData()
            handle?()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
            handle?()
        })
    }
    
}
