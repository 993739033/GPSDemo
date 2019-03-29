//
//  MapVC2.swift
//  GPSDemo
//
//  Created by apple_mini on 2019/3/29.
//  Copyright © 2019年 Scode. All rights reserved.
//

import UIKit
import MapKit


class MapVC2: UIViewController {
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSearch(_ sender: Any) {
        if searchText.text == nil{
            return
        }
        
        let text = searchText.text
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = text
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let num =  response?.mapItems.count , num > 0 else{
                return
            }
            
            let lastMapItem = response?.mapItems.last
            //[MKLaunchOptionsMapTypeKey: "hybrid"] //未生效
            lastMapItem?.openInMaps(launchOptions: nil )
        }
        
    }
    
}
