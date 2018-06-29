//
//  DLlPersonalGoodsGrid.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/22.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

class DLlPersonalGoodsGrid: DLBaseViewController {
    
    var userId:String!
    var user:DLUserModel?
    var collectionView : UICollectionView?
    
    init(userId:String) {
        super.init(nibName: nil, bundle: nil)
        self.userId = userId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initNavigationBar() {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:dScreenW/2 - 5,height:(dScreenW/2 - 5)*1.5)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.headerReferenceSize = CGSize(width: dScreenW, height: 290);

        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = BackGroundColor
        collectionView?.top = -20
        collectionView?.height += 20

        //注册一个cell
        self.view.addSubview(collectionView!)

        collectionView?.register(UINib.init(nibName: "DLGoodsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DLGoodsCollectionCell")

        collectionView?.register(UINib.init(nibName: "DLGoodsUserCard", bundle: nil), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "DLGoodsUserCard")
        
        collectionView?.emptyDataSetSource = self;
        collectionView?.emptyDataSetDelegate = self;
        request()
        
        NotificationCenter.default.rx.notification(N_reloation_upload).takeUntil(self.rx.deallocated).subscribe { [weak self](notification) in
            self?.request()
        }
    }
}

extension DLlPersonalGoodsGrid:UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "emptyData")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 128
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodId = user?.myOnsaleGoods?[indexPath.row].goods_id
        let v = DLProductDetialController.init(id:goodId ?? "")
        v.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(v, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (user?.myOnsaleGoods?.count) ?? 0
    }
    
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DLGoodsCollectionCell", for: indexPath) as! DLGoodsCollectionCell
        if let data = user?.myOnsaleGoods?[indexPath.row] {
            cell.configureData(model: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let cell:DLGoodsUserCard = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DLGoodsUserCard", for: indexPath) as! DLGoodsUserCard
        if let data = user {
            cell.configureData(model: data)
        }
        cell.delegate = self
        cell.backItem.addTarget(self, action: #selector(back), for: .touchUpInside)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.initNavigationBar()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:UIView.init())
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
}

extension DLlPersonalGoodsGrid:UsercardDelegate{
    func turnController(index: Int) {
        switch index {
        case 0:
            turnfans()
        case 1:
            turnfollow()
        case 2:
            turnpoint()
        default:
            break
        }
    }
    
    private func turnfans(){
        let vc = DLPersonalList.init(type: .fan, userId: user?.user_id ?? "")
        vc.navigationItem.title = "\(user?.shitName ?? "Ta")的粉丝"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func turnfollow(){
        let vc = DLPersonalList.init(type: .relation, userId: user?.user_id ?? "")
        vc.navigationItem.title = "\(user?.shitName ?? "Ta")的关注"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func turnpoint(){}

}

extension DLlPersonalGoodsGrid{
    func request(){
        let p:[String : String] = [
            "token":DLUserInfo.share.token ?? "",
            "userId":userId]
        
        DLNewWork.request(url: users_userHome,method:.get, parameters: p, succeed: { [weak self](result) in
            let dict:[String:Any] = result as! Dictionary
            let datas:[String:Any] = dict["datas"] as! [String : Any]
            self?.user =  DLUserModel.deserialize(from: datas)
            self?.collectionView?.reloadData()
            }, failure: {
                SVProgressHUD.showInfo(withStatus: $0)
                print($0)
        })
    }
}
