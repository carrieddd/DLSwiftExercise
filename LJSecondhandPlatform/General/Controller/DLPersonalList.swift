//
//  DLPersonalList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/27.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import CRRefresh
enum PersonalListType:String {
    case fan = "fan"
    case relation = "relation"
}


class DLPersonalList: DLBaseTableViewController {

    var listType:PersonalListType!
    var userId:String?
    var cur:Int = 1
    
    init(type:PersonalListType,userId:String) {
        super.init(tableStyle: .plain)
        listType = type
        self.userId = userId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request(handle: nil)

    }
    
    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLPersoanllisetCell")
        tableView.cr.addHeadRefresh(animator:FastAnimator()) { [weak self] in
            self?.cur = 1
            self?.request(handle: {
                self?.tableView.cr.endHeaderRefresh()
            })
        }
        
        tableView.cr.addFootRefresh(animator:NormalFooterAnimator()) { [weak self] in
            self?.cur += 1
            self?.request(handle: {
                self?.tableView.cr.endLoadingMore()

            })
        }
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DLPersonalList:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DLPersoanllisetCell = tableView.dequeueReusableCell(withIdentifier: "DLPersoanllisetCell") as! DLPersoanllisetCell
        cell.configure(model: datasource[indexPath.row] as! DLUserModel)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:DLUserModel = datasource[indexPath.row] as! DLUserModel
        let p = DLlPersonalGoodsGrid.init(userId: model.userId ?? "")
        self.navigationController?.pushViewController(p, animated: true)
    }
    
    func request(handle:(()->Void)?){
        
        let p = [
            "userId":userId ?? "",
            "type":listType.rawValue,
            "page":"\(cur)",
            "rows":"25"] as [String : Any]
        
        DLNewWork.request(url: users_getrelationUser, method: .get, parameters: p, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self.datasource = datas.map{DLUserModel.deserialize(from:$0)!}
            self.tableView.reloadData()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
}
