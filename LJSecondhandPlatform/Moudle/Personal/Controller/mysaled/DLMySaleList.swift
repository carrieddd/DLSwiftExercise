//
//  DLMySaleList.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import SDCAlertView
class DLMySaleList: DLBaseTableViewController {

    var type:SaleType!
    init(t:SaleType) {
        super.init(tableStyle: .grouped)
        self.type = t
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.registerNib(nibName: "DLMySaleBaseCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DLMySaleList:UITableViewDataSource,DLMySaleBaseCellDelegate{
    func chickButtonAction(model: DLMysaleModel) {
        
//        dl_alipay(orderStr: "")
//        return
//        确认支付
        if model.order_status == "1" {
            let adress = systemOption?.order_pay ?? ""
            let p = DLPayWebViewController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")&orderId=\(model.order_id ?? "")")
            p.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(p, animated: true)
        }
        
        guard model.order_status == "2"||model.order_status == "3" else {
            return
        }
        
        var titleStr:String = ""
        var orderType:orderType = .expressGoods
        
        switch Int(model.order_status ?? "0"){
//        case 1:
//            //确认付款
//            titleStr = "确认已经付款?"
        case 2:
            //确认发货
            titleStr = "确认已发货?"
            orderType = .expressGoods
        case 3:
            //确认收货
            titleStr = "确认已收货?"
            orderType = .deliveredOrder
        default:
            break
        }
        
        let alert = AlertController(title: titleStr, message: nil, preferredStyle: .alert)
        let cancelAction = AlertAction(title: "取消", style: .destructive) { (action) in
            alert.dismiss()
        }
        let action = AlertAction(title: "确认", style: .normal, handler: { (action) in
            order(type: orderType, orderId: model.order_id ?? "") { (errorCode) in
                guard errorCode == nil else{
                    SVProgressHUD.showInfo(withStatus: errorCode)
                    return
                }
                NotificationCenter.default.post(name: N_order_upload, object: nil)
            }
        })
        alert.addAction(cancelAction)
        alert.addAction(action)
        alert.present()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DLMySaleBaseCell = tableView.dequeueReusableCell(withIdentifier: "DLMySaleBaseCell") as!DLMySaleBaseCell
        cell.delegate = self
        cell.configureData(model: self.datasource[indexPath.section] as! DLMysaleModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model:DLMysaleModel = datasource[indexPath.section] as! DLMysaleModel
        return 200 + (model.havAction == true ? 54:0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 9
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model:DLMysaleModel = self.datasource[indexPath.section] as! DLMysaleModel
        let adress = systemOption?.order_detail ?? ""
        let p = DLPayWebViewController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")&type=\(self.type.rawValue)&orderId=\(model.order_id ?? "")")
        p.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(p, animated: true)

    }
}
