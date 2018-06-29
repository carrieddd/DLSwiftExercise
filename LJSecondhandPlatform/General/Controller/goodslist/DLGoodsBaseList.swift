//
//  DLGoodsBaseList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/27.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import UIKit

class DLGoodsBaseList: DLBaseViewController {
    
    var cid:String?
    let head = DLSelecterView.init(titles: ["推荐","附近"],frame: CGRect.init(x: 0, y: 4, width: dScreenW, height: 40))
    
    var childControllers:[DLProductGeneralList]!
    
    var scrollView:DLPageScroll = {
        $0.isPagingEnabled = true
        return $0
    }(DLPageScroll())
    
    init(catId:String) {
        super.init(nibName: nil, bundle: nil)
        cid = catId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupSubviews()
        self._setupChildViewControll()
    }
    
    private func _setupSubviews()  {
        self.view.addSubview(head)
        head.type = .average
        head.index = 0
        head.backgroundColor = .white
        head.delegate = self
        
    }
    
    func _setupChildViewControll(){
        
        var p = [
            "cid":cid ?? "0",
            "keyword":""]
        let p0 = DLProductGeneralList.init(parameters: p)
        
        p["locationX"] = locManager.lat
        p["locationY"] = locManager.lon

        let p1 = DLProductGeneralList.init(parameters: p)
        childControllers = [p0,p1]
        view.backgroundColor = BackGroundColor
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(head.bottom)
            make.bottom.equalTo(0)
        }
        //        scrollView.frame = CGRect(x: 0, y: 44, width: dScreenW, height: self.view.frame.height)
        scrollView.contentSize = CGSize(width: dScreenW * CGFloat(childControllers.count), height:0)
        scrollView.delegate = self
        
        for (index,value) in childControllers.enumerated() {
            scrollView.addSubview(value.view)
            self.addChildViewController(value)
            value.view.snp.makeConstraints { (make) in
                make.size.equalTo(scrollView.snp.size)
                make.top.equalTo(0)
                make.left.equalTo(CGFloat(index) * dScreenW)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DLGoodsBaseList:UIScrollViewDelegate,DLselecterDelegate{
    func selecterViewSelectItem(index: Int) {
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset.x = CGFloat(index) * dScreenW
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        head.index = Int(scrollView.contentOffset.x/dScreenW)
    }
}
