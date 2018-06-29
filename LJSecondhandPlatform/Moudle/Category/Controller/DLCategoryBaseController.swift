//
//  DLCategoryBaseController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/14.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLCategoryBaseController: DLBaseViewController {
    
    
    var head:DLSelecterView?
//        = DLSelecterView.init(titles: ["出售中","已下架","草稿箱"],frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 44))
    
    var childControllers:[DLGoodsBaseList]!
    var categorys:[DLCategoryModel]!
    var index:Int = 0
    
    init(catArr:[DLCategoryModel]) {
        super.init(nibName: nil, bundle: nil)
        categorys = catArr
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "分类"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView:DLPageScroll = {
        $0.isPagingEnabled = true
        return $0
    }(DLPageScroll())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupSubviews()
        self._setupChildViewControll()
    }
    
    private func _setupSubviews()  {
        let titles:[String] = categorys.map{$0.cateName ?? "categoryNameError"}
        
        head = DLSelecterView.init(titles:titles,frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 44))
        self.view.addSubview(head!)
        head?.type = .onebyone
        head?.index = index
        scrollView.contentOffset.x = CGFloat(index) * dScreenW
        head?.delegate = self
        
    }
    
    func _setupChildViewControll(){
        
        childControllers = categorys.map{DLGoodsBaseList.init(catId: $0.cateId!)}
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(head?.bottom ?? 0)
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

extension DLCategoryBaseController:UIScrollViewDelegate,DLselecterDelegate{
    func selecterViewSelectItem(index: Int) {
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset.x = CGFloat(index) * dScreenW
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        head?.index = Int(scrollView.contentOffset.x/dScreenW)
    }
}