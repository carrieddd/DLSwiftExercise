//
//  DLCameraViewController.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/31.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
protocol DLCameraDelegate {
    func didSelectImg(imgs:[UIImage]);
}
class DLCameraViewController: DLBaseViewController {

    var delegate:DLCameraDelegate?
    let imageScroll = DLImagesScroll.init()
    let bottom:DLCameraBottomView = Bundle.main.loadNibNamed("DLCameraBottomView", owner: nil, options: nil)?.first as! DLCameraBottomView
    let cameraManager = DLCameraManager()
    var isStatusBarHidden = false {
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupSubview()
        
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        self.isStatusBarHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func _setupSubview(){
        view.backgroundColor = UIColor.black
        view.addSubview(bottom)
        bottom.delegate = self
        bottom.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(170)
        }
        //中间摄像头
        let contentView = UIView()
        contentView.backgroundColor = .clear
        view.insertSubview(contentView, at: 0)
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(bottom.snp.top)
        }
        
        contentView.layoutIfNeeded()
        if  cameraManager.canUserCamear(){
            cameraManager.configureCamera(contentView: contentView)
        }

        //返回按钮
        let cancelBtn = DLBaseButton.init { [weak self](sender) in
            self?.delegate?.didSelectImg(imgs: self?.imageScroll.images ?? [])
            self?.back()
        }
        view.addSubview(cancelBtn)
        cancelBtn.setImage(UIImage.init(named: "close_white"), for: .normal)
        cancelBtn.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        
        //切换镜头
        let changeCbtn = DLBaseButton.init { [weak self](sender) in
            sender.isSelected = !sender.isSelected
            self?.cameraManager.changeCamera(isFront: sender.isSelected)
        }
        view.addSubview(changeCbtn)
        changeCbtn.setImage(UIImage.init(named: "changeCamera_white"), for: .normal)
        changeCbtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-12)
            make.height.equalTo(48)
//            make.width.equalTo(38)
        }

        //闪光灯按钮
        let flashBtn = DLBaseButton.init { [weak self](sender) in
            self?.cameraManager.flashAction(model: sender.isSelected ? .on:.off)
            sender.isSelected = !sender.isSelected
        }
        view.addSubview(flashBtn)
        flashBtn.setImage(UIImage.init(named: "flash_white"), for: .normal)
        flashBtn.setImage(UIImage.init(named: "flash_close"), for: .selected)
        flashBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(changeCbtn.snp.left).offset(-12)
            make.height.equalTo(48)
//            make.width.equalTo(38)
        }
        
        //照片选择栏
        view.insertSubview(imageScroll, belowSubview: bottom)
        imageScroll.imagesStatus = self
        imageScroll.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(bottom.snp.top)
            make.height.equalTo(80)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
}

extension DLCameraViewController{
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.setStatusBarHidden(true, with: .none)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.setStatusBarHidden(false, with: .none)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraManager.startRunning()
        if self.imageScroll.images.count > 0 {self.haveImage()}
    }
}

extension DLCameraViewController: DLCameraToolDelegate,DLImagesScrollDelegate{
    func next() {
        guard imageScroll.images.count > 0 else {
            return
        }
        
        self.delegate?.didSelectImg(imgs: imageScroll.images)
        self.back()
    }
    
    func haveImage() {
        bottom.nextBtn.isSelected = true
        imageScroll.snp.removeConstraints()
        imageScroll.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottom.snp.top)
            make.height.equalTo(80)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func imageEmpty() {
        bottom.nextBtn.isSelected = false
        imageScroll.snp.removeConstraints()
        imageScroll.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(bottom.snp.top)
            make.height.equalTo(80)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func changeCamera(isfront: Bool) {
        cameraManager.changeCamera(isFront: isfront)
    }
    
    func takePhoto() {
        cameraManager.shutterCamera { (succeed, image) in
            self.imageScroll.images.append(image)
        }
    }
    
    func openLibrary() {
        
        let ablum = TZImagePickerController.init(maxImagesCount: 9-imageScroll.images.count, delegate: self)
        ablum?.allowPickingVideo = false
        ablum?.allowPickingGif = false
        ablum?.allowTakePicture = false
        ablum?.allowPreview = false
        ablum?.statusBarStyle = .default
        ablum?.naviBgColor = NAVBGCOLOR
        ablum?.naviTitleColor = NAVTITLECOLOR
        ablum?.barItemTextColor = NAVTITLECOLOR
    
        self.present(ablum!, animated: true) {
            
        }
    }
}

extension DLCameraViewController:TZImagePickerControllerDelegate{
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        photos.forEach{self.imageScroll.images.append($0)}
    }
}
