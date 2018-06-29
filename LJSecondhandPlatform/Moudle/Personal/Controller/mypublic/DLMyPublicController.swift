//
//  DLMyPublicController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/11.
//  Copyright © 2018年 iOS110. All rights reserved.
//
import UIKit

class DLMyPublicController: DLBaseViewController {
        
    let head = DLSelecterView.init(titles: ["出售中","已下架","草稿箱"],frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 44))
    
    var childControllers:[DLMyPublicList]!
    
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
        self.view.addSubview(head)
        head.type = .average
        head.index = 0
        
        head.delegate = self
        
    }
    
    func _setupChildViewControll(){
        
        childControllers = [DLMyPublicList.init(t:"1"),
                            DLMyPublicList.init(t:"-2"),
                            DLMyPublicList.init(t:"0"),
        ]
        
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

extension DLMyPublicController:UIScrollViewDelegate,DLselecterDelegate{
    func selecterViewSelectItem(index: Int) {
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset.x = CGFloat(index) * dScreenW
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        head.index = Int(scrollView.contentOffset.x/dScreenW)
    }
}

