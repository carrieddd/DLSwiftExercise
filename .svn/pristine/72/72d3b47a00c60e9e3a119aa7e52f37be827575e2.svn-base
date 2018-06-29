//
//  DLCameraManager.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/5/31.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit
import AVFoundation
import SDCAlertView

class DLCameraManager: NSObject {
//    private var currentDevice:AVCaptureDevice!   //获取设备:如摄像头
//    private var input:AVCaptureDeviceInput!   //输入流
    private var deviceFront:AVCaptureDevice!   //输入流
    private var input_front:AVCaptureDeviceInput!   //输入流
    private var deviceBack:AVCaptureDevice!   //输入流
    private var input_back:AVCaptureDeviceInput!   //输入流

    private var photoOutput:AVCaptureStillImageOutput! //输出流
    private var output:AVCaptureMetadataOutput! //当启动摄像头开始捕获输入
    private var session:AVCaptureSession!//会话,协调着intput到output的数据传输,input和output的桥梁
    private var previewLayer:AVCaptureVideoPreviewLayer! //图像预览层，实时显示捕获的图像

 
    func canUserCamear() -> Bool {
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for:.video)
        if authStatus == .denied {

            let alert = AlertController(title: "请打开相机权限", message: "设置-隐私-相机", preferredStyle: .alert)
            let action = AlertAction(title:"确定", style: .normal) { (action) in

            }
            alert.addAction(action)
            alert.present()
            
            return false
        }else {
            return true
        }
    }
    
    func configureCamera(contentView:UIView){
        guard let devices = AVCaptureDevice.devices(for: .video) as? [AVCaptureDevice] else { return } //初始化摄像头设备
        
        guard let device_back = devices.filter({ return $0.position == .back }).first else{ return}
        guard let device_front = devices.filter({ return $0.position == .front }).first else{ return}
        
        self.deviceFront = device_front
        self.deviceBack = device_back
        self.input_front = try? AVCaptureDeviceInput(device:device_front)
        self.input_back = try? AVCaptureDeviceInput(device:device_back)

//        self.currentDevice = device_back
        //输入流初始化
//        self.input = try? AVCaptureDeviceInput(device: device_back)
        //照片输出流初始化
        self.photoOutput = AVCaptureStillImageOutput.init()
        //输出流初始化
        self.output = AVCaptureMetadataOutput.init()
        //生成会话
        self.session = AVCaptureSession.init()
        self.session.sessionPreset = .high
        if(self.session.canAddInput(self.input_back)){
            self.session.addInput(self.input_back)
        }
        if(self.session.canAddOutput(self.photoOutput)){
            self.session.addOutput(self.photoOutput)
        }
        self.previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        self.previewLayer.frame = contentView.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(self.previewLayer)
        //启动
        if ((try? deviceBack.lockForConfiguration()) != nil) {
            if deviceBack.isFlashModeSupported(.auto) {
                deviceBack.flashMode = .auto
            }
            //自动白平衡
            if deviceBack.isWhiteBalanceModeSupported(.autoWhiteBalance) {
                deviceBack.whiteBalanceMode = .autoWhiteBalance
            }
            deviceBack.unlockForConfiguration()
        }

        //闪光灯
        do{ try deviceBack.lockForConfiguration() }catch{ }
        if deviceBack.hasFlash == false { return }
        deviceBack.flashMode = AVCaptureDevice.FlashMode.auto
        deviceBack.unlockForConfiguration()
    }
    
    //MARK:拍照按钮点击事件
    func shutterCamera(handle:@escaping (_ succeed:Bool,_ media:UIImage)->Void){
        let videoConnection: AVCaptureConnection? = photoOutput.connection(with: AVMediaType.video)
        if videoConnection == nil {
            print("take photo failed!")
            handle(false,UIImage())
            return
        }
        photoOutput.captureStillImageAsynchronously(from: videoConnection ?? AVCaptureConnection(), completionHandler: {(_ imageDataSampleBuffer: CMSampleBuffer?, _ error: Error?) -> Void in
            if imageDataSampleBuffer == nil {
                handle(false,UIImage())
                return
            }
            let imageData: Data? = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)   //照片数据流
            handle(true,UIImage(data: imageData!) ?? UIImage())
        })
    }
    
    func startRunning() {
        self.session.startRunning()
    }
    
    //MARK: 闪光灯开关
    func flashAction(model:AVCaptureDevice.FlashMode){
        try? deviceBack.lockForConfiguration()
        deviceBack.flashMode = model
        deviceBack.unlockForConfiguration()
    }

    func cancelActin(){
        self.session.stopRunning()
    }
    
    func changeCamera(isFront:Bool) {
        cancelActin()
        if isFront {
            session.removeInput(input_back)
            if session.canAddInput(input_front){
                session.addInput(input_front)
                startRunning()
            }
        }else{
            session.removeInput(input_front)
            if session.canAddInput(input_back){
                session.addInput(input_back)
                startRunning()
            }
        }        
    }
}
