//
//  MapVC.swift
//  GPSDemo
//
//  Created by apple_mini on 2019/3/29.
//  Copyright © 2019年 Scode. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    var latitude: Double! ,longitude: Double!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        placeCamare()
        
    }
    
    func showUser(){
        map.showsUserLocation = true
        map.userLocation.title = "Me"
        map.userTrackingMode = .followWithHeading //监听用户位置及朝向信息
        print("map reset")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.map.mapType = .standard
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        map.region = viewRegion
        showUser()
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
       
    }
    
    func placeCamare(){
        let mapCamare = MKMapCamera()
        mapCamare.centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapCamare.pitch = 45
        mapCamare.altitude = 500
        mapCamare.heading = 45
        map.camera = mapCamare
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("annotation created!!!")
        var annotationView = self.map.dequeueReusableAnnotationView(withIdentifier: "mapAnnotation") as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mapAnnotation")
        }
        
        annotationView?.pinTintColor = UIColor.cyan
        //      annotationView?.backgroundColor = UIColor.brown
        annotationView?.animatesDrop = true
        annotationView?.canShowCallout = true
        return annotationView!
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        //关闭键盘
        self.searchText.resignFirstResponder()
        
        if(searchText.text == nil){
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText.text!) { (places, error) in
            if let err = error{
                print(err)
                return
            }
            
            print("查询个数：\(String(describing: places?.count))")
            
            self.map.removeAnnotations(self.map.annotations)//去除原有的annoations
            for place in places!{
                let annotation = MyAnnotation(coordinate: place.location!.coordinate)
                annotation.city = place.locality
                annotation.state = place.administrativeArea
                annotation.streetAddress = place.thoroughfare
                annotation.zip = place.postalCode
                self.map.addAnnotation(annotation)
                
            }
            
            if places!.count > 0{
                let lastmark = places!.last
                let viewRegion = MKCoordinateRegionMakeWithDistance(lastmark!.location!.coordinate, 1000, 1000)
                self.map.region = viewRegion
            }
        }
        
    }
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func onSegChange(_ sender: Any) {
        let sc = sender as! UISegmentedControl
        switch sc.selectedSegmentIndex {
        case 1:
            map.mapType = .satellite
        case 2:
            map.mapType = .hybrid
        default:
            map.mapType = .standard
        }
        placeCamare()
        showUser()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
