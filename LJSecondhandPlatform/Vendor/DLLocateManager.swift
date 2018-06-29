//
//  DLLocateManager.swift
//  LJSecondhandPlatform
//
//  Created by iOS110 on 2018/6/27.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import Foundation
import CoreLocation

let locManager = DLLocation.init()
class DLLocation: NSObject {
    var locationManager = CLLocationManager()
    var lat:String? = "0"
    var lon:String? = "0"
    
    func loadLocation()
    {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            //定位方式
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            //更新距离
            locationManager.distanceFilter = 1000
            //发出授权请求
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    }
}


extension DLLocation:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            lat = String(format: "%.6f", location.coordinate.latitude)
            lon = String(format: "%.6f", location.coordinate.longitude)
            print("纬度:\(lon!)")
            print("经度:\(lat!)")
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)

    }
}