//
//  DMDPrimerVC.swift
//  APP_GCD_OperationQueue
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit


//Grand Central Dispatch
class DMDPrimerVC: UIViewController {
    
    //MARK: - Variables locales
    //Imagen pesada: Necesitamos que tarde la descarga para ver el efecto
    let URLImagen = "http://s1.1zoom.me/big3/652/Lykan_Hypersport_W_448900.jpg"
    //Web ligera
    let URLWeb = "https://es.wikipedia.org/wiki/Wikipedia:Portada"
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myWeb: UIWebView!
    
    
    //MARK: - IBActions
    @IBAction func showDataFromGCDACTION(_ sender: Any) {
        //downloadDataSync()
        // downloadDataASync()
       downloadDataASyncCALLBACK()
    }
    
    
    
    //MARK: - Utils
    
    ///Permite realizar una descarga síncronamente.
    ///Se bloquea todo hasta que descarga la imagen primero y después la web.
    func downloadDataSync(){
        do{
            //Recuperar la imagen de internet
            myImagen.image = UIImage(data: try Data(contentsOf: URL(string: URLImagen)!))
            //Recuperar web
            myWeb.loadRequest(URLRequest(url: URL(string: URLWeb)!))
            
        }catch let error{
            print("Error en la descarga de los datos.")
            print(error.localizedDescription)
        }
    }
    
    ///Permite realizar una descarga asíncronamente.
    ///Crea una cola en segundo plano que es la que descarga el contenido
    func downloadDataASync(){
        
        //Crear cola en segundo plano
        DispatchQueue.global(qos: .default).async {
            do{
                //Recuperar la imagen de internet
                let imagen = UIImage(data: try Data(contentsOf: URL(string: self.URLImagen)!))
                //Recuperar web
                let web = URLRequest(url: URL(string: self.URLWeb)!)
                
                //Llamada a la cola del primer plano
                DispatchQueue.main.async {
                    self.myImagen.image = imagen
                    self.myWeb.loadRequest(web)
                }
                
            }catch let error{
                print("Error en la descarga de los datos.")
                print(error.localizedDescription)
            }
            
            
            
        }
        
    }
    
    ///Llamada asíncrona, define los callbacks
    func downloadDataASyncCALLBACK(){
        
        downloadInfo(callbackImage: {  (imagenData) in
            self.myImagen.image = imagenData
        }) { (requestData) in
            self.myWeb.loadRequest(requestData)
            
        }
        
    }
    
    ///Permite descargar la imagen y la web asíncronamente y llamar al callback asíncronamente
    func downloadInfo( callbackImage : @escaping (_ imageData : UIImage ) -> (),
                       callbackWeb : @escaping(_ webData : URLRequest)  ->() ){
        
        
        
        //Crear cola en segundo plano
        DispatchQueue.global(qos: .default).async {
            do{
                //Recuperar la imagen de internet
                let imagen = UIImage(data: try Data(contentsOf: URL(string: self.URLImagen)!))
                //Recuperar web
                let web = URLRequest(url: URL(string: self.URLWeb)!)
                
                //Llamadas a la cola del primer plano
                callbackImage(imagen!)
                callbackWeb(web)
                
            }catch let error{
                print("Error en la descarga de los datos.")
                print(error.localizedDescription)
            }
            
            
            
        }
        
        
    }
    
    
    
}
