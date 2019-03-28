//
//  ViewController.swift
//  GPSDemo
//
//  Created by apple_mini on 2019/3/28.
//  Copyright © 2019年 Scode. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        print("开始定位！")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingHeading()
        print("停止定位！")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationLabel.text = "\(locations.last?.coordinate.latitude)__\(locations.last?.coordinate.longitude)"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations.last!) { (placemarks, error) in
            if error != nil{
                print("error:\(error?.localizedDescription)")
            }else if placemarks != nil && placemarks!.count > 0 {
                let plcaemark = placemarks![0]
                let name = plcaemark.name
                self.locationLabel.text = name
            }
            
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        locationManager.stopUpdatingHeading()
        print("停止定位！")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error)")
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedAlways:
            print("已经授权")
        case .authorizedWhenInUse:
            print("使用时授权")
        case .denied:
            print("拒绝")
        case .restricted:
            print("受限")
        case .notDetermined:
            print("用户未确定")
        }
    }

}

