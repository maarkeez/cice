//
//  CurrentViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentViewController: UIViewController {
    
    //MARK: - Variables locales
    //Local que vamos a mostrar en la chincheta
    var garito : Garito?
    
    //Cuadrado blanco que sale al pulsar una chincheta del mapa
    var calloutSelected : UIImage?
    
    // Permite gestionar la localización
    var locationManager = CLLocationManager()
    
    
    // Preajustes
    var actualizandoLocalizacion = false {
        didSet{
            if(actualizandoLocalizacion){
                myBuscarUbicacionBTN.isUserInteractionEnabled = false
                myBuscarUbicacionBTN.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                myActivityIndicator.isHidden = false
                myActivityIndicator.startAnimating()
            }else{
                myBuscarUbicacionBTN.isUserInteractionEnabled = true
                myBuscarUbicacionBTN.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                myActivityIndicator.isHidden = true
                myActivityIndicator.stopAnimating()
                myAnadir.isEnabled = false
            }
        }
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var myMenuButtonBTN: UIBarButtonItem!
    
    @IBOutlet weak var myMapa: MKMapView!
    @IBOutlet weak var myAnadir: UIBarButtonItem!
    @IBOutlet weak var myBuscarUbicacionBTN: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    //MARK:- IBActions
    
    @IBAction func obtenerLocalizacion(_ sender: Any) {
        iniciaLocationManager()
    }
    
    
    
    //MARK: - LIFE VC
    deinit{
        print("Borro CurrentViewController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recupero info de las chinchetas guardadas
        GaritoRepository.shared.cargarDatos()
        
        
        
        //Dejo en reposo el boton de buscar
        actualizandoLocalizacion = false
        
        if revealViewController() != nil {
            myMenuButtonBTN.target = revealViewController()
            myMenuButtonBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myMapa.delegate = self
        
        //Aquí se insertarán las anotaciones en el mapa
        //Recuperándolas de USER_DEFAULTS
        myMapa.addAnnotations(GaritoRepository.shared.garitos)
        
    }
    
    //MARK: - Utils
    func iniciaLocationManager(){
        
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            present(showAlert("Localización desactivada", mensaje: "Por favor, active la localización para esta aplicación en los ajustes del dispositivo", tituloAccion: "OK"), animated: true, completion: nil)
        default:
            if CLLocationManager.locationServicesEnabled() {
                actualizandoLocalizacion = true
                myAnadir.isEnabled = false
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
                
                //Región = Mi localización, a 100 y 100 metros
                //myMapa.userLocation.coordinate necesita HABILITAR EL CHECK en el mainstoryboard para el mapa
                let region = MKCoordinateRegionMakeWithDistance(myMapa.userLocation.coordinate, 100, 100)
                myMapa.setRegion(myMapa.regionThatFits(region), animated: true)
            }
        }
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tagGaritoSegue"){
            
            //Como el VC del detalle tiene Navigation,
            //Primero recuperamos el navigation
            let navVC = segue.destination as! UINavigationController
            //Después recuperamos el TOP view controller, es decir, primera vista controller
            let detalleVC = navVC.topViewController as! DetalleGarito
            //Asigno el garito seleccionado
            detalleVC.garito = garito
            //Me asigno como delegado
            detalleVC.delegate = self
        }
        
        if(segue.identifier == "showPinImage") {
            let navVC = segue.destination as! UINavigationController
            let detalleVC = navVC.topViewController as! ImagenGarito
            detalleVC.calloutNewImage = calloutSelected
        }
    }
}


//MARK: - Core location delegate
extension CurrentViewController : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("OK! Actualizada la localización")
        
        guard let userLocation = locations.last else {
            return
        }
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        //Recuperar el nombre de la calle, etc. a partir de las coordenadas actuales.
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            
            if(error == nil){
                var direccion = ""
                if let placemark = placemarks?.last{
                    direccion = self.getString(from: placemark)
                }
                
                //Generar el objeto del garito actual
                self.garito = Garito(direccion: direccion, latitud: latitud, longitud: longitud, imagen: "")
                
                //Ya hemos recuperado la localización, por lo que podemos volver a pulsar
                self.actualizandoLocalizacion = false
                
                //Habilitar botón de añadir
                self.myAnadir.isEnabled = true
                
            }else{
                //Ya no hemos recuperado la localización, por lo que podemos volver a pulsar
                self.actualizandoLocalizacion = false
                
                let popUp = showAlert("Ooops!", mensaje: "Se ha producido un error mientras se recuperaba la información de la ubicación actual", tituloAccion: "Aceptar")
                self.present(popUp, animated: true, completion: nil)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** ERROR EN CORE LOCATION ***")
        print(error.localizedDescription)
        
    }
    
    //MARK: - Utils Core location delegate
    func getString(from placemark: CLPlacemark) -> String {
        var direccion = ""
        
        if let calle = placemark.thoroughfare, let numero = placemark.subThoroughfare {
            direccion += calle + " " + numero + "\n"
        }
        
        if let CP = placemark.postalCode, let localidad = placemark.locality {
            direccion += CP + " " + localidad + "\n"
        }
        
        if let area = placemark.administrativeArea, let pais = placemark.country{
            direccion += area + " " + pais + "\n"
        }
        
        return direccion
    }
}


//MARK: - Delegado de garito detalle
extension CurrentViewController : DetalleGaritoDelegate {
    func detalleBarEtiquetado(_ detalleVC: DetalleGarito, barEtiquetado: Garito) {
        GaritoRepository.shared.garitos.append(barEtiquetado)
        GaritoRepository.shared.guardarDatos()
        
    }
}


//MARK: - Extensión para tomar el control del mapa
extension CurrentViewController : MKMapViewDelegate{
    
    ///Se recicla la imagen repintando las chinchetas (annotations) al movernos por el mapa
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Chincheta azul cuando estoy viendo mi localización. Oculto la chincheta
        if ( annotation is MKUserLocation ){
            return nil
        }
        
        // My chincheta
        var annotationView = myMapa.dequeueReusableAnnotationView(withIdentifier: "garitoPin")
        
        //Si no traigo datos, los añado. En caso contrario los mantengo
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "garitoPin")
        }else{
            annotationView?.annotation = annotation
        }
        
        //Configuramos la chincheta
        //Contendrá un título, un label, una imagen
        if let place = annotation as? Garito{
            
            //Configurar Callout
            let imageName = place.imagen
            if let imagenURL = GaritoRepository.shared.dataBaseImagenUrl() {
                do {
                    //Recuperamos la imagen como Data de los ficheros de la applicación que hemos guardado
                    let imagenData = try Data(contentsOf: imagenURL.appendingPathComponent(imageName))
                    
                    //Asigno el valor a la variable local
                    calloutSelected = UIImage(data: imagenData)
                    //Reescalo la imagen
                    let myImageNewScale = resizeImage(calloutSelected!, newWidth: 40)
                    
                    //Botón que llevará al detalle cuando pulsemos la imagen
                    let btnNewAction = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40 ))
                    btnNewAction.setImage(myImageNewScale, for: .normal)
                    
                    
                    //Colocar el botón con la imagen a la izquierda del callout
                    annotationView?.leftCalloutAccessoryView = btnNewAction
                    
                    //Cambiar el icono del pin de la chincheta
                    annotationView?.image = #imageLiteral(resourceName: "img_pin")
                    
                    //Permitir mostrar el callout
                    annotationView?.canShowCallout = true
                    
                }catch let error{
                    print("Error en la configuración de la imagen de la chincheta. \(error.localizedDescription)")
                }
            }
            
        }
        return annotationView
    }
    
    ///Redimensiona una imagen a partir de una imagen y su ancho
    ///devuelve la imagen redimensionada
    func resizeImage(_ image : UIImage, newWidth : CGFloat) -> UIImage {
        //Calculo la escala a la que quiero redimensionar
        let scale = newWidth / image.size.width
        
        //Calculo de la nueva altura
        let newHeight = image.size.height * scale
        
        
        //Comenzar contexto
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        //Repintar el recuadro donde se va a insertar la imagen
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        //Recuperar el recuadro
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //Finalizar contexto
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView{
            performSegue(withIdentifier: "showPinImage", sender: view)
        }
        
    }
}
