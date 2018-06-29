//
//  DLProductDetialController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/29.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import CRRefresh
class DLProductDetialController: DLBaseTableViewController {
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var enjoyBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commentBtn: UIButton!
    var goodID:String?
    var detailModel:DLGoodsDetailModel?
    var commentText:String = ""
    
    @IBOutlet weak var avaterImg: UIImageView!
    @IBOutlet weak var wantBtn: UIButton!

    init(id:String) {
        super.init(nibName: "DLProductDetialController", bundle: nil, tableStyle: .grouped)
        self.goodID = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cr.beginHeaderRefresh()
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "详情"
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
        tableView.registerNib(nibName: "DLUserCardCell")
        tableView.registerNib(nibName: "DLCommentHead")
        tableView.registerNib(nibName: "DLCommentCell")
        
        tableView.cr.addHeadRefresh(animator:FastAnimator()) { [weak self] in
            self?.request {
                self?.tableView.cr.endHeaderRefresh()
                self?.tableView.cr.resetNoMore()
            }
        }
        
        bottomView.isHidden = true
        ViewRadius(view: self.avaterImg, radius: 12)
    }
    
    @IBAction func confirmOrder() {
        let v = DLOrderConfirmController.init(nibName: "DLOrderConfirmController", bundle: nil)
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @IBAction func want(_ sender: UIButton) {
        requestWant(sender: sender, handle: nil)
    }
    
    @IBAction func comment(_ sender: UIButton) {
        sender.isEnabled = false
        XHInputView.show(with: .default, historyText: commentText, configurationBlock: { [weak self](inputView) in
            inputView?.placeholder = "更多宝贝细节问问卖家："
            inputView?.delegate = self
            inputView?.backgroundColor = BackGroundColor
        }) { [weak self](string) -> Bool in
            self?.requestCommentGoods(str: string ?? "", handle: {
                sender.isEnabled = true
                self?.commentText = ""
            })
            return true
        }
    }
    
    @IBAction func buy() {
        
        guard let adress = systemOption?.order_submit else {
            
            getSystomOption { [weak self](system) in
                self?.buy()
            }
            return
        }
        
        let p = DLPayWebViewController.init(urlStr: "\(adress)?token=\(DLUserInfo.share.token ?? "")&goodsId=\(detailModel?.goods?.goodsId ?? "")")
        p.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(p, animated: true)
    }

    @IBAction func avatarClick() {
        let p = DLlPersonalGoodsGrid.init(userId: self.detailModel?.userInfo?.userId ?? "")
        self.navigationController?.pushViewController(p, animated: true)
    }
}

extension DLProductDetialController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 2{
            self.avatarClick()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return (self.detailModel?.goodsComment?.count ?? 0)  + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:DLProductDetialHead = tableView.dequeueReusableCell(withIdentifier: "DLProductDetialHead") as!DLProductDetialHead
            if let model = detailModel{cell.configureData(model:model)}
            return cell
        case 1:
            let cell:DLProductDetialImgGroup = tableView.dequeueReusableCell(withIdentifier: "DLProductDetialImgGroup") as!DLProductDetialImgGroup
            if let model = detailModel{cell.configureData(model:model)}
            return cell
            
        case 2:
            let cell:DLUserCardCell = tableView.dequeueReusableCell(withIdentifier: "DLUserCardCell") as!DLUserCardCell
            if let model = detailModel{cell.configureData(model:model)}
            return cell
            
        case 3:
            
            switch indexPath.row{
            case 0:
                let cell:DLCommentHead = tableView.dequeueReusableCell(withIdentifier: "DLCommentHead") as!DLCommentHead
                cell.commentCountLbl.text = "留言（\(detailModel?.goodsComment?.count ?? 0)）"
                return cell
                
            default:
                let cell:DLCommentCell = tableView.dequeueReusableCell(withIdentifier: "DLCommentCell") as!DLCommentCell
                if let comment = detailModel?.goodsComment?[indexPath.row - 1]{
                    cell.configureData(model:comment)
                }

                return cell
                
            }
            
        default:
            let cell:DLUserCardCell = tableView.dequeueReusableCell(withIdentifier: "DLUserCardCell") as!DLUserCardCell
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
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
            return self.detailModel?.contentHeight ?? 100
            
        case 2:
            return 145
            
        case 3:
            
            switch indexPath.row{
            case 0:
                return 54
                
            default:
                return detailModel?.goodsComment?[indexPath.row - 1].commentHeight ?? 120//120为默认的错误高度
            }

        default:
            return 0
        }
    }
    
    
}

extension DLProductDetialController{
    
    func requestWant(sender:UIButton, handle:(()->Void)?){
        guard DLUserInfo.verifyToken() else {
            return
        }
        sender.isSelected = !sender.isSelected
        sender.isUserInteractionEnabled = false
        let p:[String:String] = [
            "goodsId":self.detailModel?.goods?.goodsId ?? "",
            "token":DLUserInfo.share.token ?? ""]
        
        DLNewWork.request(url: users_favoriteGoods, method: .get, parameters: p, succeed: { (result) in
            sender.isUserInteractionEnabled = true
//            SVProgressHUD.showSuccess(withStatus: "已添加！")
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            sender.isUserInteractionEnabled = true
            sender.isSelected = !sender.isSelected
            print($0)
        })
    }
    
    func requestCommentGoods(str:String, handle:(()->Void)?){
        guard !NSString.isEmpty(str) else {
            return
        }
        let p = ["goodsId":goodID ?? "",
                 "token":DLUserInfo.share.token ?? "",
                 "content":str,
                 ]
        DLNewWork.request(url: shop_comment, method: .post, parameters: p, succeed: { (result) in
            
            let dict:[String:Any] = result as! Dictionary
            let datas:[String:Any] = dict["datas"] as! [String : Any]
            
            if let commentModel = DLGoodsComment.deserialize(from: datas){
                commentModel.caculateHeight()
                
                self.detailModel?.goodsComment?.append(commentModel)
//                self.tableView.reloadSection(3, with: .none)
                self.tableView.insertRow(at: IndexPath.init(row: (self.detailModel?.goodsComment?.count ?? 0), section: 3), with: .bottom)
                self.tableView.scrollToBottom()
            }
            
            handle?()
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
            handle?()
        })
    }
    
    func request(handle:(()->Void)?){
        DLNewWork.request(url: shop_getGoodsDetail, method: .get, parameters: ["id":goodID ?? "","token":DLUserInfo.share.token ?? ""], succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[String:Any] = dict["datas"] as! [String : Any]
            self?.detailModel = DLGoodsDetailModel.deserialize(from:datas)
            self?.datasource = ["head","img","seller","comment"]
            self?.caculateHeight()
            self?.tableView.reloadData()
            self?.bottomView.isHidden = false
            self?.avaterImg.setImageWith(URL.init(string: self?.detailModel?.userInfo?.avatar ?? ""), placeholder: UIImage.init(named: "avater_d"))
            if DLUserInfo.share.userModel?.user_id == self?.detailModel?.userInfo?.userId{
                self?.enjoyBtn.isEnabled = false
                self?.buyBtn.isEnabled = false
            }
            
            self?.wantBtn.isSelected = self?.detailModel?.isFavorited ?? false
            handle?()

            
            let queue    = DispatchQueue.global()
            let group = DispatchGroup()
            var shit = 0
            
    
            self?.detailModel?.goodsAlbum?.forEach{album in
                group.enter()
                
                queue.async {
                    shit += 1
                    print("loading \(shit) ")
                        album.caculateSize()
                    print("complete \(shit) ")
                        group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self?.caculateHeight()
                self?.tableView.reloadData()
            }
            
        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
            handle?()
        })
    }
    
    func caculateHeight(){
        func caculateImgGroupCellHeight(){
            var height:CGFloat = 0
            height += 54+12
            height += 20+12+12
            
            let destrH = self.detailModel?.goods?.goodsBrief?.DL_heightForComment(font: UIFont.init(name: "PingFangSC-Regular", size: 14)!, width: dScreenW - 24)
            height += destrH ?? 0 + 12
            
            self.detailModel?.goodsAlbum?.forEach{
                if let size = $0.imgSize {
                    let rate:CGFloat = size.height / size.width
                    height += (rate * (dScreenW-24)) + 12
                }
            }
            self.detailModel?.contentHeight = height
        }
        
        func caculateCommentHeight(){
            self.detailModel?.goodsComment?.forEach({ (comment) in
                comment.caculateHeight()
            })
        }
        
        caculateImgGroupCellHeight()
        caculateCommentHeight()
    }
}

extension DLProductDetialController:XHInputViewDelagete{
    func xhInputViewWillHide(_ inputView: XHInputView!) {

    }
    
    func xhInputViewWillShow(_ inputView: XHInputView!) {

    }
    
    func xhKeyBoardDidDisappear(_ string: String!) {
        commentBtn.isEnabled = true
        commentText = string
    }

}
