//
//  Garito.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import MapKit

@objc(Garito)
class Garito : NSObject, NSCoding{
    
    var direccion : String = ""
    var latitud : Double = 0.0
    var longitud : Double = 0.0
    var imagen : String = ""
    
    override init(){
        super.init()
    }
    
    init(direccion : String, latitud : Double, longitud : Double, imagen : String){
        self.direccion = direccion
        self.latitud = latitud
        self.longitud = longitud
        self.imagen = imagen
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //La latitud falla ¿por qué?
            let direccion = aDecoder.decodeObject(forKey: "direccion") as! String
            let latitud = aDecoder.decodeDouble(forKey: "latitud") as! Double
            let longitud = aDecoder.decodeDouble(forKey: "longitud") as! Double
            let imagen = aDecoder.decodeObject(forKey: "imagen") as! String
        
            self.init(direccion : direccion, latitud : latitud, longitud : longitud, imagen : imagen)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(direccion, forKey: "direccion")
        aCoder.encode(latitud, forKey: "latitud")
        aCoder.encode(longitud, forKey: "longitud")
        aCoder.encode(imagen, forKey: "imagen")
    }
    
}

//MARK: - Extensiones
extension Garito : MKAnnotation {
   
    var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        }
    }
    
    var title: String? {
        get{
            return "Garito de Madrid"
        }
    }
    
    var subtitle: String? {
        get{
            return direccion.replacingOccurrences(of: "\n", with: "")
        }
    }
}
