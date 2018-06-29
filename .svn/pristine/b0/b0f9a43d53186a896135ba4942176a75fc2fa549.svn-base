//
//  DLHomeBaseViewController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

class DLHomeBaseViewController: DLBaseViewController {
    var cates:[DLCategoryModel]?
    
    let headBG = UIView.init()
    var headCate:DLCategoryView?
    let headSelect = DLSelecterView.init(titles: ["推荐","附近"],frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 40))
    
    var childControllers:[DLProductGeneralList]!
    
    var scrollView:DLPageScroll = {
        $0.isPagingEnabled = true
        return $0
    }(DLPageScroll())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupSubviews()
        self._setupChildViewControll()
        requestCategory()
        
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "首页"
        self.hiddenBackItem(flag: true)
    }
    
    private func _setupSubviews()  {
        view.addSubview(scrollView)

        view.addSubview(headBG)
        headSelect.type = .average
        headSelect.index = 0
        headSelect.backgroundColor = .white
        headSelect.delegate = self
        
    }
    
    func _setupChildViewControll(){
        
        var p = [
            "cid":"0",
            "keyword":""]
        let p0 = DLProductGeneralList.init(parameters: p)
        
        p["locationX"] = locManager.lat
        p["locationY"] = locManager.lon
        
        let p1 = DLProductGeneralList.init(parameters: p)
        childControllers = [p0,p1]
        view.backgroundColor = BackGroundColor
        scrollView.contentSize = CGSize(width: dScreenW * CGFloat(childControllers.count), height:0)
        scrollView.delegate = self
    }
    
    func layoutSubview(){
        
        headBG.frame = CGRect.init(x: 0, y: 0, width: dScreenW, height: self.headSelect.bottom)
        headBG.backgroundColor = .red
        scrollView.frame = CGRect.init(x: 0, y: 0, width: dScreenW, height: dScreenH)
        self.headBG.backgroundColor = .yellow
        self.view.backgroundColor = .blue
        self.scrollView.backgroundColor = .brown
        for (index,value) in childControllers.enumerated() {
            value.tableView.tableHeaderView = UIView.init(frame: headBG.bounds)
            _ = value.tableView.rx.observe(CGPoint.self, "contentOffset").takeUntil(self.rx.deallocated).subscribe(onNext: { (contentOffset) in
//                print("contentOffset====\(String(describing: contentOffset))")

                let headerViewScrollStopY:CGFloat = self.headSelect.top
                let tableView = value.tableView
                let contentOffsetY:CGFloat = tableView!.contentOffset.y;
                // 滑动没有超过停止点,头部视图跟随移动
                if (contentOffsetY < headerViewScrollStopY) {
                    self.headBG.top = 0 - (contentOffset?.y)!;
//                    // 同步tableView的contentOffset
                    self.childControllers.forEach({ (vc) in
                        if (vc.tableView.contentOffset.y != tableView?.contentOffset.y) {
                            vc.tableView.contentOffset = (tableView?.contentOffset)!;
                        }
                    })
//                    // 头部视图固定位置
                }else{
                    self.headBG.top = -headerViewScrollStopY
                    let v:DLProductGeneralList = self.childControllers[self.headSelect.index]
                    if v.tableView.contentOffset.y < headerViewScrollStopY{
                        var contentOffset = v.tableView.contentOffset
                        contentOffset.y = headerViewScrollStopY
                        v.tableView.contentOffset = contentOffset
                    }
                }
            })
            
            scrollView.addSubview(value.view)
            self.addChildViewController(value)
            
            value.view.size = scrollView.size
            value.view.top = 0
            value.view.left = CGFloat(index) * dScreenW
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DLHomeBaseViewController:UIScrollViewDelegate,DLselecterDelegate{
    func selecterViewSelectItem(index: Int) {
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset.x = CGFloat(index) * dScreenW
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headSelect.index = Int(scrollView.contentOffset.x/dScreenW)
    }
}

extension DLHomeBaseViewController:DLCategoryViewDelegate{
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
    
    func requestCategory(){
        DLNewWork.request(url: shop_getGoodsCateList, method: .get, parameters: nil, succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self?.cates = datas.map{DLCategoryModel.deserialize(from:$0)!}
            let rows:Int = Int(ceil(Double((self?.cates?.count) ?? 0)/Double(DLCategoryView.widthCount)))
            let size = CGSize.init(width: dScreenW, height: DLCategoryView.vHight*CGFloat(rows))
            self?.headCate = DLCategoryView.init(item: (self?.cates) ?? [], frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height + 12))
            self?.headCate?.delegate = self
            
            self?.headBG.addSubview((self?.headCate)!)
            self?.headSelect.top = (self?.headCate?.bottom)!
            self?.headBG.addSubview((self?.headSelect)!)
            self?.headBG.height = (self?.headSelect.bottom)!
            self?.layoutSubview()
            }, failure: {
                SVProgressHUD.showInfo(withStatus: $0)
                print($0)
        })
    }
}
