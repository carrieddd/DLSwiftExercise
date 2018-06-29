//
//  DLCategoryList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/14.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLCategoryList: DLBaseTableViewController {

    var catblock:((_ cat:DLCategoryModel)->Void)?
    
    
    init(_ block:((_ cat:DLCategoryModel)->Void)?) {
        super.init(tableStyle: .plain)
        self.catblock = block
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestCategory()
        // Do any additional setup after loading the view.
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLDefaultCell")
    }

    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "选择分类"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DLCategoryList:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DLDefaultCell = tableView.dequeueReusableCell(withIdentifier: "DLDefaultCell") as! DLDefaultCell
        
        let categoryModel:DLCategoryModel = self.datasource[indexPath.row] as! DLCategoryModel
        cell.labelL.text = categoryModel.cateName
        cell.imgL.image = UIImage.init()
        cell.labalLPadding.constant = 18
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryModel:DLCategoryModel = self.datasource[indexPath.row] as! DLCategoryModel
        self.catblock?(categoryModel)
        self.back()
    }
    
    func requestCategory(){
        DLNewWork.request(url: shop_getGoodsCateList, method: .get, parameters: nil, succeed: { (result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self.datasource = datas.map{DLCategoryModel.deserialize(from:$0)!}
            self.datasource.enumerated().forEach({ (index,value) in
                let qunima:DLCategoryModel = value as! DLCategoryModel
                if qunima.cateId == "0"{ self.datasource.remove(at: index)}
            })
            self.tableView.reloadData()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
}
