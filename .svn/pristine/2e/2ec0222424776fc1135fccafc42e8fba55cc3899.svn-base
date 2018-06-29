//
//  DLMySaleController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

enum SaleType:String {
    case sale = "2"
    case buy = "22"
}

class DLMySaleController: DLBaseViewController {

    var dataSource:[DLMysaleModel] = []
    
    var type:SaleType
    init(type:SaleType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let head = DLSelecterView.init(titles: ["全部","待付款","待发货","待收货","待评价","退款"],frame: CGRect.init(x: 0, y: 0, width: dScreenW, height: 44))

    
    var childControllers:[DLMySaleList]!
    
    var scrollView:DLPageScroll = {
        $0.isPagingEnabled = true
        return $0
    }(DLPageScroll())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupSubviews()
        self._setupChildViewControll()
        request()
        
        NotificationCenter.default.rx.notification(N_order_upload).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.request()
            print("更新userinfo")
        }

    }

    private func _setupSubviews()  {
        self.view.addSubview(head)
        head.type = .onebyone
        head.index = 0
        
        head.delegate = self
        
    }
    
    func _setupChildViewControll(){
        
        childControllers = [DLMySaleList.init(t: self.type),
                            DLMySaleList.init(t: self.type),
                            DLMySaleList.init(t: self.type),
                            DLMySaleList.init(t: self.type),
                            DLMySaleList.init(t: self.type)
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

extension DLMySaleController:UIScrollViewDelegate,DLselecterDelegate{
    func selecterViewSelectItem(index: Int) {
        UIView.animate(withDuration: 0.4) {
            self.scrollView.contentOffset.x = CGFloat(index) * dScreenW
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        head.index = Int(scrollView.contentOffset.x/dScreenW)
    }
}

extension DLMySaleController{
    func request(){
        
        self.childControllers.forEach { (v) in
            v.datasource.removeAll()
        }
        
        let p:[String:String] = ["orderstatus":"-1",
                 "page":"1",
                 "rows":"999",
                 "status":type.rawValue,
                 "token":DLUserInfo.share.token!]
        
        DLNewWork.request(url: users_getmygoods,method:.get, parameters: p, succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[[String:Any]] = dict["datas"] as! [[String : Any]]
            self?.dataSource = datas.map{DLMysaleModel.deserialize(from:$0)!}
            
            let tempDatas:[DLMysaleModel] = (self?.dataSource.map({ (data) in
                
                var tempData = data
                if self?.type == .sale,data.order_status == "2"{
                    tempData.havAction = true
                }
                
                if self?.type == .buy,(data.order_status == "1" || data.order_status == "3"){
                    tempData.havAction = true
                }
                
                switch Int(data.order_status ?? "0"){
                case 1:
                    self?.childControllers[1].datasource.append(tempData)
                case 2:
                    self?.childControllers[2].datasource.append(tempData)
                case 3:
                    self?.childControllers[3].datasource.append(tempData)
                case 4:
                    self?.childControllers[4].datasource.append(tempData)
                case 5:
                    self?.childControllers[5].datasource.append(tempData)
                default:
                    break
                }
                return tempData
            })) ?? []
            self?.childControllers[0].datasource = tempDatas
            self?.childControllers.forEach{$0.tableView.reloadData()}
            
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })

        
    }
}
