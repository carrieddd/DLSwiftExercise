//
//  DLPublicReviewController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/13.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLPublicReviewController: DLBaseTableViewController {

    @IBOutlet weak var bottomView: UIView!
    
    
    var p:[String:String]?
    var imgs:[UIImage]? = []
    var imgCellHeight:CGFloat? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caculateImgGroupCellHeight()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initTableView() {
        super.initTableView()
        tableView.snp.removeConstraints()
        tableView.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        })
        
        tableView.registerNib(nibName: "DLProductDetialHead")
        tableView.registerNib(nibName: "DLProductDetialImgGroup")
    }
    
    @IBAction func publicAction() {
        publicGoods()
    }
}

extension DLPublicReviewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:DLProductDetialHead = tableView.dequeueReusableCell(withIdentifier: "DLProductDetialHead") as!DLProductDetialHead
            
            cell.goodsBriefLbl.text = p?["goodsName"] ?? ""
            cell.nowPrice.text = "¥\(p?["nowPrice"] ?? "0")"
            let nowPriceString = NSMutableAttributedString.init(string: cell.nowPrice.text!)
            nowPriceString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12)], range: NSRange.init(location: 0, length: 1))
            cell.nowPrice.attributedText = nowPriceString
            
            cell.originalPrice.text = "¥\(p?["originalPrice"] ?? "0")"
            let priceString = NSMutableAttributedString.init(string: cell.originalPrice.text!)
            priceString.addAttributes([NSAttributedStringKey.strikethroughStyle : NSNumber.init(value: 1)], range: NSRange.init(location: 1, length: priceString.length-1))
            cell.originalPrice.attributedText = priceString
            
            cell.province.text = "\(p?["city"] ?? "")"
            cell.browseCount.text = "预览 0"
            
            return cell
            
        default:
            let cell:DLProductDetialImgGroup = tableView.dequeueReusableCell(withIdentifier: "DLProductDetialImgGroup") as!DLProductDetialImgGroup
            
            
            cell.images.forEach{$0.removeFromSuperview()}
            cell.images.removeAll()
            cell.goodsBriefLbl.text = p?["goodsBrief"] ?? ""
            imgs?.forEach{
                let image = shitImageView.init(image: $0)
                cell.addSubview(image)
                cell.images.append(image)
            }
            cell.configureImgs(images:cell.images)
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 11
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 126
            
        case 1:
            return imgCellHeight!
            
        default:
            return 0
        }
    }
    
    func caculateImgGroupCellHeight(){
        var height:CGFloat = 0
        height += 54+12
        height += 20+12+12
        
        let destrH = (p?["goodsBrief"] ?? "").DL_heightForComment(font: UIFont.init(name: "PingFangSC-Regular", size: 14)!, width: dScreenW - 24)
        height += destrH
        
        imgs?.forEach{
            let tempImgV = UIImageView.init(image: $0)
            let rate:CGFloat = tempImgV.size.height / tempImgV.size.width
            height += (rate * (dScreenW-24)) + 12
        }
        imgCellHeight = height
    }

    func publicGoods() {
        SVProgressHUD .show(withStatus: "上传发布中...")
        uploadImg(imgs: imgs!) { [weak self](coverK, imgsK) in
            
            var shitImgsK = imgsK
            shitImgsK.removeFirst()
            self?.p?["albumImage"] = shitImgsK
            self?.p?["goodsImage"] = coverK
            
            DLNewWork.request(url: shop_createGoods, method: .post, parameters:self?.p, succeed: { (result) in
                SVProgressHUD.showSuccess(withStatus: "发布成功!")
                NotificationCenter.default.post(name: N_users_publicGoods, object: nil)
                
                if NSString.isEmpty(self?.p?["goodId"]){
                    self?.backDeep()
                }
                
            }, failure: {
                SVProgressHUD.showInfo(withStatus: $0)
                print($0)
            })
        }
    }
}
