//
//  DLPublicController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/28.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import SDCAlertView
let N_users_publicGoods = NSNotification.Name(rawValue:"users_publicGoods_notification")

class DLPublicController: DLBaseViewController {
    
    @IBOutlet weak var headBG: UIView!
    
    @IBOutlet weak var goodsNameTF: DLDefaultTextField1!
    @IBOutlet weak var goodsContentTF: YYTextView!
    @IBOutlet weak var nowPriceTF: UITextField!
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var locateBtn: UIButton!
    
    @IBOutlet weak var catButton: UIButton!
    let head = DLPublicHeadView.init(frame: .zero)

    var province = ""
    var city = ""
    var area = ""
    var catId = ""
    var goodId:String?

    @IBOutlet weak var scrollWidth: NSLayoutConstraint!
    
    var handle:((_ v:DLPublicController)->Void)?
    
    init(configure:((_ v:DLPublicController)->Void)?) {
        super.init(nibName: "DLPublicController", bundle: nil)
        handle = configure 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupUI()
        handle?(self)
        scrollWidth.constant = dScreenW
        NotificationCenter.default.rx.notification(N_users_publicGoods).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.cleanUI()
            self?.dismiss(animated: true, completion: {
            })
        }
    }

    override func initNavigationBar() {
        super.initNavigationBar()
        self.navigationItem.title = "发布"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _setupUI(){
        head.delegate = self
        headBG.addSubview(head)
        head.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    @IBAction func getLocate(_ sender: UIButton) {
        self.goodsContentTF.endEditing(true)
        CZHAddressPickerView.areaPickerView { [weak self](province, city, area) in
            sender.setTitle(" \(province ?? "") \(city ?? "") \(area ?? "") ", for: .selected)
            sender.setTitleColor(TEXTDARK_1, for: .selected)
            sender.isSelected = true
            self?.province = province ?? ""
            self?.city = city ?? ""
            self?.area = area ?? ""
        }
    }
    
    @IBAction func clickCategory(_ sender: UIButton) {
        let v = DLCategoryList.init { [weak self](catModel) in
            sender.setTitle(catModel.cateName, for: .normal)
            self?.catId = catModel.cateId ?? "0"
        }
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @IBAction func publicAction() {

        if NSString.isEmpty(goodsNameTF.text){
            SVProgressHUD.showInfo(withStatus: "请输入标题！")
            return
        }
        
        if NSString.isEmpty(nowPriceTF.text) {
            SVProgressHUD.showInfo(withStatus: "请输入宝贝价格！")
            return
        }
        
//        if NSString.isEmpty(originalPrice.text) {
//            SVProgressHUD.showInfo(withStatus: "请输入宝贝原价格！")
//            return
//        }

        if head.imageScroll?.images.count == 0 {
            SVProgressHUD.showInfo(withStatus: "至少上传一张商品图片！")
            return
        }
        
        if NSString.isEmpty(goodsContentTF.text) {
            SVProgressHUD.showInfo(withStatus: "需要添加商品描述！")
            return
        }
        
        if NSString.isEmpty(area) {
            SVProgressHUD.showInfo(withStatus: "请选择地区!")
            return
        }
        
        if NSString.isEmpty(catId) {
            SVProgressHUD.showInfo(withStatus: "请选择分类!")
            return
        }

        let v = DLPublicReviewController.init(nibName: "DLPublicReviewController", bundle: nil, tableStyle: .grouped)
        v.navigationItem.title = "发布预览"
        v.p = ["cateId":catId,
                                 "goodsName":(self.goodsNameTF.text) ?? "",
                                 "nowPrice":(self.nowPriceTF.text) ?? "",
                                 "originalPrice":self.originalPrice.text ?? "",
                                 "goodsBrief":self.goodsContentTF.text ?? "",
                                 "goodsContent":"",
                                 "token":DLUserInfo.share.token ?? "",
                                 "province":self.province ,
                                 "area":self.area ,
                                 "city":self.city ,
                                 "goodsId":self.goodId ?? ""
        ]
        v.imgs = head.imageScroll?.images
        self.navigationController?.pushViewController(v, animated: true)
    }
 
    override func back() {
        
        if head.imageScroll?.images.count == 0{
            super.back()
            return
        }

        let alert = AlertController(title: "是否存入草稿箱", message: "存入草稿箱后，下次可继续编辑", preferredStyle: .alert)
        let cancelAction = AlertAction(title: "取消", style: .destructive) { (action) in
            super.back()
        }
        let action = AlertAction(title: "确认", style: .normal, handler: { [weak self](action) in
            self?.releaseGoods()
        })
        alert.addAction(cancelAction)
        alert.addAction(action)
        alert.present()

    }
    
}

extension DLPublicController:DLCameraDelegate,DLPublicHeadDelegate{
    func didSelectImg(imgs: [UIImage]) {
        head.imageScroll?.images = imgs
    }
    
    func openCamera() {
        let v = DLCameraViewController()
        v.delegate = self
        v.imageScroll.images = head.imageScroll?.images
        self.navigationController?.pushViewController(v, animated: true)
    }
}

extension DLPublicController{
    func cleanUI() {
        goodsNameTF.text = ""
        nowPriceTF.text = ""
        originalPrice.text = ""
        goodsContentTF.text = ""
        head.imageScroll?.images.removeAll()
        locateBtn.isSelected = false
        province = ""
        area = ""
        city = ""
    }
    
    func releaseGoods() {
        SVProgressHUD .show(withStatus: "保存中...")
        uploadImg(imgs: head.imageScroll?.images ?? []) { [weak self](coverK, imgsK) in
            
            var shitImgsK = imgsK
            shitImgsK.removeFirst()
            let p:[String:String] = [
                                     "goodsId":self?.goodId ?? "",
                                     "cateId":self?.catId ?? "",
                                     "goodsName":(self?.goodsNameTF.text) ?? "",
                                     "nowPrice":(self?.nowPriceTF.text) ?? "",
                                     "originalPrice":self?.originalPrice.text ?? "",
                                     "goodsImage":coverK,
                                     "goodsBrief":self?.goodsContentTF.text ?? "",
                                     "goodsContent":"",
                                     "token":DLUserInfo.share.token ?? "",
                                     "albumImage":shitImgsK,
                                     "province":self?.province ?? "",
                                     "area":self?.area ?? "",
                                     "city":self?.city ?? "",
                                     ]
            
            DLNewWork.request(url: shop_preReleaseGood, method: .post, parameters:p, succeed: { (result) in
                SVProgressHUD.showSuccess(withStatus: "保存成功!")
                NotificationCenter.default.post(name: N_users_publicGoods, object: nil)
                self?.cleanUI()
                if (self?.navigationController?.viewControllers.count)! < 2 {
                    self?.dismiss(animated: true, completion: nil)
                }else{
                    self?.navigationController?.popViewController(animated: true)
                }
            }, failure: {
                SVProgressHUD.showInfo(withStatus: $0)
                print($0)
            })
        }
    }
    
    func request(goodId:String){
        DLNewWork.request(url: shop_getGoodsDetail, method: .get, parameters: ["id":goodId ,"token":DLUserInfo.share.token ?? ""], succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[String:Any] = dict["datas"] as! [String : Any]
            let detailModel = DLGoodsDetailModel.deserialize(from:datas)
            self?.area = detailModel?.goodsExtray?.area ?? ""
            self?.city = detailModel?.goodsExtray?.city ?? ""
            self?.province = detailModel?.goodsExtray?.province ?? ""
            self?.locateBtn.setTitle(" \(self?.province ?? "") \(self?.city ?? "") \(self?.area ?? "") ", for: .selected)
            self?.locateBtn.isSelected = true
            let urls:[String] = detailModel?.goodsAlbum?.map{$0.image ?? ""} ?? []
            self?.head.imageScroll?.addImgUrl(urls: urls )

        }, failure: {
            SVProgressHUD.showInfo(withStatus: $0)
            print($0)
        })
    }
    
}

extension DLPublicController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.goodsContentTF.endEditing(true)
    }
    
}
