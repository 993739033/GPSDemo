//
//  MyAnnotation.swift
//  GPSDemo
//
//  Created by apple_mini on 2019/3/29.
//  Copyright © 2019年 Scode. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D//地理位置
    var streetAddress: String!//街道信息
    var city: String!//城市信息属性
    var state: String!//州省市信息
    var zip: String!//邮编
    

    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
    
    
    var title: String?{
        return "你的位置！"
    }
    
    var subtitle: String?{
        return "\(self.state)>>\(self.city)>>\(self.zip)>>\(self.streetAddress)"
    }
    
}
