//
//  GaritoRepository.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

class GaritoRepository : NSObject {
    
    static let shared = GaritoRepository()
    
    var garitos : [Garito] = []
    
    func dataBaseUrl() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let urlDirectorio = URL(fileURLWithPath: documentDirectory)
            return urlDirectorio.appendingPathComponent("garito.data")
        }
        return nil
    }
    
    func guardarDatos(){
        if let pathGaritosData = dataBaseUrl(){
            NSKeyedArchiver.archiveRootObject(garitos, toFile: pathGaritosData.path)
            print("Datos guardados en: ")
            print(pathGaritosData.path)
        }else{
            print("Error guardando los datos. No existe la ruta para garito.data")
        }
    }
    
    func cargarDatos() -> [Garito]{
        if let pathGaritosData = dataBaseUrl(),let datosGaritos = NSKeyedUnarchiver.unarchiveObject(withFile: pathGaritosData.path) as? [Garito]{
            garitos = datosGaritos
            return garitos
        }else{
            print("Error recuperando los datos para multitud.data")
            return []
        }
    }
    
    
    func dataBaseImagenUrl() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let urlDirectorio = URL(fileURLWithPath: documentDirectory)
            return urlDirectorio
        }
        return nil
    }
    
}
