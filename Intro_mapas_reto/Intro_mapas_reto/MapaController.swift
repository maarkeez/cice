//
//  MapaController.swift
//  Intro_mapas_reto
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaController: UIViewController {
    
    //MARK: - Variables locales
    var locationManager = CLLocationManager()
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBOutlet weak var myEtiquetaInfo: UILabel!
    @IBOutlet weak var myMapa: MKMapView!

    @IBAction func setMapType(_ sender: Any) {
        
        switch mySegment.selectedSegmentIndex {
        case 0:
            myMapa.mapType = MKMapType(rawValue: 0)!
        case 1:
            myMapa.mapType = MKMapType(rawValue: 1)!
        default:
            myMapa.mapType = MKMapType(rawValue: 2)!
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //DELEGADO
        locationManager.delegate = self
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func crearChincheta(){
        let chincheta = MKPointAnnotation()
        chincheta.coordinate = CLLocationCoordinate2D()
    }
    
}

extension MapaController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let localizacionUsuario = locations.first!
        
        let latitud = localizacionUsuario.coordinate.latitude
        let longitud = localizacionUsuario.coordinate.longitude
        
        let localizacion = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        
        let nivelDeZoom = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: localizacion, span: nivelDeZoom)
        
        
        myMapa.setRegion(region, animated: true)
        
        
        myEtiquetaInfo.text = "Latitud: \(latitud), longitud: \(longitud)"
        
        
        
    }
    
    
}
