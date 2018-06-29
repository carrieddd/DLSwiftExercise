//
//  DLBaseTableViewController.swift
//  LJGeographyFinance
//
//  Created by iOS110 on 2017/12/29.
//  Copyright © 2017年 dongl. All rights reserved.
//

import UIKit
import SnapKit
class DLBaseTableViewController: DLBaseViewController,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var tableView:DLTableView!
    var datasource:[Any] = []
    
    init(tableStyle:UITableViewStyle) {
        super.init(nibName: nil, bundle: nil)
        tableView = DLTableView.init(vc: self, style:tableStyle)

    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, tableStyle:UITableViewStyle) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tableView = DLTableView.init(vc: self, style:tableStyle)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        // Do any additional setup after loading the view.
    }
    
    func initTableView(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        tableView.backgroundColor = BackGroundColor
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "emptyData")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }

}
