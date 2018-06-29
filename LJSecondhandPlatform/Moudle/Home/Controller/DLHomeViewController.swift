//
//  DLHomeViewController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import CRRefresh
class DLHomeViewController: DLBaseTableViewController {
    var cur = 1
    var cates:[DLCategoryModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cr.beginHeaderRefresh()
        NotificationCenter.default.rx.notification(N_users_publicGoods).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.tableView.cr.beginHeaderRefresh()
            print("发布更新首页")
        }

    }

    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLHomeBaseCell")
        cates = []
        datasource = []
        tableView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottomMargin.equalTo(18)
        }
        
        
        tableView.cr.addHeadRefresh(animator:FastAnimator()) { [weak self] in
            self?.cur = 1
            self?.requestCategory()
            self?.request {
                self?.tableView.cr.endHeaderRefresh()
            }
        }
        
        tableView.cr.addFootRefresh(animator:NormalFooterAnimator()) { [weak self] in
            self?.cur += 1
            self?.request {
                self?.tableView.cr.endLoadingMore()
//                self?.tableView.cr.noticeNoMoreData()
//                self?.tableView.cr.resetNoMore()
            }
        }
    }
    
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
        self.hiddenBackItem(flag: true)

        let searchBtn = DLBaseButton.init { (sender) in

        }
        searchBtn.setImage(UIImage.init(named: "search_m"), for: .normal)
        searchBtn.setTitle(" 你需要什么?", for: .normal)
        searchBtn.setTitleColor(NAVSearchTextCOLOR, for: .normal)
        searchBtn.backgroundColor = NAVSearchBGCOLOR
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        searchBtn.frame = CGRect.init(x: 0, y: 0, width: dScreenW - 24, height: 30)
//        searchBtn.contentHorizontalAlignment = .left
        ViewRadius(view: searchBtn, radius: 15)
        
        self.navigationItem.titleView = searchBtn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DLHomeViewController:contentImageClickDelegate{
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

extension DLHomeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DLHomeBaseCell = tableView.dequeueReusableCell(withIdentifier: "DLHomeBaseCell") as!DLHomeBaseCell
        cell.model = datasource[indexPath.row] as! DLGoodsModel
        //        cell.imageGroup = datasource[indexPath.row] as! [String]
        cell.contentClickDelegate = self
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let v = DLProductDetialController(nibName: "DLProductDetialController", bundle: nil, tableStyle:.grouped)
        let model = datasource[indexPath.row] as! DLGoodsModel
        let v = DLProductDetialController.init(id:model.goods?.goodsId ?? "")
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = datasource[indexPath.row] as! DLGoodsModel
        switch data.goodsAlbum?.count {
        case 1:
            return 520
        case 2:
            return 345
        case 3:
            return 400
        case 4:
            return 520
        default:
            return 275
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let selHead = DLSelecterView.init(titles: ["推荐","附近"], frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 30))
        selHead.backgroundColor = UIColor.white
        
        return selHead
    }
    
}

extension DLHomeViewController:DLCategoryViewDelegate {
    func chooseCat(category: DLCategoryModel) {
        print("qunima \(category.cateName ?? "error")")
        let p = DLCategoryBaseController.init(catArr: cates ?? [])
        var index = 0
        cates?.enumerated().forEach{
            if $1.cateId == category.cateId{
                index = $0
            }
        }
        p.index = index
        p.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(p, animated: true)
    }
    
    func request(handle:(()->Void)?){
        let parameters = [
            "cid":"0",
            "keyword":"",
            "page":"\(cur)",
            "rows":"25"] as [String : Any]
        
        DLNewWork.request(url: shop_getGoodsList,method:.get, parameters: parameters, succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            if self?.cur == 1{self?.datasource.removeAll()}
            self?.datasource.append(contentsOf: datas.map{DLGoodsModel.deserialize(from:$0)!})
            self?.tableView.reloadData()
            handle?()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
            handle?()
        })
    }
    
    func requestCategory(){
        DLNewWork.request(url: shop_getGoodsCateList, method: .get, parameters: nil, succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self?.cates = datas.map{DLCategoryModel.deserialize(from:$0)!}
            let rows:Int = Int(ceil(Double((self?.cates?.count) ?? 0)/Double(DLCategoryView.widthCount)))
            let size = CGSize.init(width: dScreenW, height: DLCategoryView.vHight*CGFloat(rows))
            let head:DLCategoryView = DLCategoryView.init(item: (self?.cates) ?? [], frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height + 12))
            head.delegate = self
            self?.tableView.tableHeaderView = head
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
    
}

