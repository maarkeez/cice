//
//  DMDMapa.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import MapKit

protocol DMDMapaDelegate {
    func setDireccion(_ direccion: String)
}

class DMDMapa : UIViewController {
    
    // MARK: - Variables locales
    let regionRadius: CLLocationDistance = 100
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var delegate : DMDMapaDelegate?

    //MARK: - IBOutlets
    @IBOutlet weak var myMapa: MKMapView!
    @IBOutlet weak var myStreetLBL: UILabel!
    
    //MARK: - IBActions
    @IBAction func guardarACTION(_ sender: Any) {
        if let direccion = myStreetLBL.text {
            self.delegate?.setDireccion(direccion)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    ///Activa el servicio de geo-localizacion
    @IBAction func setCurrentLocationACTION(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pedir autorización al usuario
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // Callback cuando se pulsa el mapa
        let pulsacion = UILongPressGestureRecognizer(target: self, action: #selector(manejarPulsacion(_:)))
        myMapa.addGestureRecognizer(pulsacion)
        
        //Establecer delegado y precisión si se activa el servicio de geo-localización
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
        
        myStreetLBL.text = ""
        
        
        
    }
    
    //MARK: - Utils
    ///Centra el mapa haciendo zoom.
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        myMapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    ///Crea una chinceta en el punto indicado
    func updatePin(_ location: CLLocationCoordinate2D){
        myMapa.removeAnnotation(annotation)
        
        annotation.coordinate = location
        myMapa.addAnnotation(annotation)
    }
    
    ///Recupera el nombre de la dirección más cerca mediante reverse-gecoding
    ///Lo muestra en pantalla asociandolo a la etiqueta correspondiente
    func updateStreetName(_ location : CLLocation){
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Detalles del sitio
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            // print(placeMark.addressDictionary ?? "")
            
            var direccion = ""
            
            if let calle = placeMark.addressDictionary!["Street"] as? String {
               direccion += calle + ". "
            }
            
            if let codigoPostal = placeMark.addressDictionary!["ZIP"] as? String {
                direccion += "(" + codigoPostal + ") "
            }
            
            if let ciudad = placeMark.addressDictionary!["City"] as? String {
                direccion += ciudad + " "
            }
            
            
            self.myStreetLBL.text = direccion

        }
    }
    
    /// Tras una pulsación en el mapa, recupera las coordenadas y lo refleja por pantalla.
    func manejarPulsacion(_ gestureReconizer : UIGestureRecognizer) {
        
        let location = gestureReconizer.location(in: myMapa)
        let coordinate = myMapa.convert(location,toCoordinateFrom: myMapa)
        
        let clLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        updatePin(coordinate)
        updateStreetName(clLocation)
    }
}



//MARK: - Extension para gestionar la geo-localización
extension DMDMapa : CLLocationManagerDelegate {
    
    ///Metodo llamado cuando se activa el servicio de GEO-localizacion
    ///Centra el mapa y crea un chincheta en el punto actual geo-localizado
    ///Detiene el servicio de geolocalización al finalizar.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(location.latitude) \(location.longitude)")
        
        centerMapOnLocation(location: CLLocation(latitude: location.latitude, longitude: location.longitude))
        updatePin(location)
        updateStreetName(CLLocation(latitude: location.latitude, longitude: location.longitude))
        locationManager.stopUpdatingLocation()
    }
}
