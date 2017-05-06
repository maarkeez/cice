//
//  DMDMap.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DMDMap: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    var initialLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myMap.delegate = self
        
        
        let regionRadius: CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((initialLocation?.coordinate)!,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        myMap.setRegion(coordinateRegion, animated: true)
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = (initialLocation?.coordinate)!
        dropPin.title = "New York City"
        myMap.addAnnotation(dropPin)
        
        
       
        
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

}
