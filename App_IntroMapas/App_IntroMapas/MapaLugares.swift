//
//  MapaLugares.swift
//  App_IntroMapas
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaLugares: UIViewController {
    
    //MARK : Variables locales
    let locationManager = CLLocationManager()
    
    //MARK : - IBOutlets
    @IBOutlet weak var myMapa: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( indiceObjetoSeleccionado == -1 ) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            let customLat = NSString(string: customLugaresFavoritos[indiceObjetoSeleccionado]["lat"]!).doubleValue
             let customLong = NSString(string: customLugaresFavoritos[indiceObjetoSeleccionado]["long"]!).doubleValue
            let customLocation = CLLocationCoordinate2D(latitude: customLat, longitude: customLong)
            let region = MKCoordinateRegion(center: customLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            
            myMapa.setRegion(region, animated: true)
            
            
            let chincheta = MKPointAnnotation()
            chincheta.coordinate = customLocation
            chincheta.title = customLugaresFavoritos[indiceObjetoSeleccionado]["name"]
            self.myMapa.addAnnotation(chincheta)
            
        }
        let gesto = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraLugarFavorito(_:)))
        gesto.minimumPressDuration = 2
        myMapa.addGestureRecognizer(gesto)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
    func muestraLugarFavorito(_ gesture : UIGestureRecognizer){
        if gesture.state == UIGestureRecognizerState.began{
            let puntoTocado = gesture.location(in: myMapa)
            
            let nuevoLugarFavoritoCoordenada = myMapa.convert(puntoTocado, toCoordinateFrom: myMapa)
            let localizacionNuevaCoordenada = CLLocation(latitude: nuevoLugarFavoritoCoordenada.latitude, longitude: nuevoLugarFavoritoCoordenada.longitude)
            
            
            CLGeocoder().reverseGeocodeLocation(localizacionNuevaCoordenada, completionHandler: { (placeMarks, error) in
                var calle = ""
                var numero = ""
                var customTitulo = ""
                
                if let cusmtomPlaceMark = placeMarks?[0]{
                    if cusmtomPlaceMark.thoroughfare != nil {
                        calle = cusmtomPlaceMark.thoroughfare!
                    }
                    
                    if cusmtomPlaceMark.subThoroughfare != nil {
                        numero = cusmtomPlaceMark.subThoroughfare!
                    }
                    
                    customTitulo = "\(calle) \(numero)"
                    
                }
                
                if customTitulo == ""{
                    customTitulo = "Punto añadido el \(Date())"
                }
                
                let chincheta = MKPointAnnotation()
                chincheta.coordinate = nuevoLugarFavoritoCoordenada
                chincheta.title = customTitulo
                self.myMapa.addAnnotation(chincheta)
                
                customLugaresFavoritos.append(["name":customTitulo, "lat": "\(nuevoLugarFavoritoCoordenada.latitude)", "long":"\(nuevoLugarFavoritoCoordenada.longitude)"])
                
            })
        }
    }
    
}

extension MapaLugares : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localizacion = locations[0]
        
        let latitud = localizacion.coordinate.latitude
        let longitud = localizacion.coordinate.longitude
        let centro = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: centro, span: span  )
        myMapa.setRegion(region, animated: true)
    }
}
