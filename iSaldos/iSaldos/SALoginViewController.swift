//
//  SALoginViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
//Para el video
import AVFoundation

class SALoginViewController: UIViewController {

    
    //MARK: - Variables locales
    var reproductor: AVPlayer!
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myUserName: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myAccederBTN: UIButton!
    @IBOutlet weak var myRegistrarseBTN: UIButton!
    
    
    
    //MARK: - IBActions
    @IBAction func myAccederACTION(_ sender: Any) {
        let sign = APISignIn(username: myUserName.text!, password: myPassword.text!)
        do{
           try sign.signUser()
        }catch let error {
            print("Error myAccederACTION: \(error.localizedDescription)")
            
            present(muestraAlertVC("Lo sentimos", messageData: "\(error.localizedDescription)"), animated: true, completion: nil)
        }
        
        performSegue(withIdentifier: "jumpForLogin", sender: self)
        
        
        
    }
    
    //Tendrá un video de fondo
    override func viewDidLoad() {
        super.viewDidLoad()

        //Mostrar el video de fondo
        showVideoInVC()
        
        //Redondear los botones
        myAccederBTN.layer.cornerRadius = 5
        myRegistrarseBTN.layer.cornerRadius = 5
        
    }
    
    //MARK: - Utils
    
    ///Permite mostrar un video de fondo, el video está almacenado en la aplicación
    func showVideoInVC() {
        
        
        let rutaVideo = Bundle.main.path(forResource: "Nike_iOS", ofType: "mp4")
        
        //Asignar el video
        reproductor = AVPlayer(url: URL(fileURLWithPath: rutaVideo!))
        
        //No hacer nada al acabar el vídeo
        reproductor.actionAtItemEnd = .none
        
        //Construye el layer alrededor del vídeo
        let capaDelReproductor = AVPlayerLayer(player:  reproductor)
        
        //Lo ajusto a los bordes
        capaDelReproductor.frame = view.frame
        
        //Hago zoom sin distorsionar
        capaDelReproductor.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //zPosition para capas, lo añado a la primera posición del array de capas
        view.layer.insertSublayer(capaDelReproductor, at: 0)
        
        //Observador sobre el reproductor
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItem),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: reproductor.currentItem)
        
        //Arrancar en el inicio
        reproductor.seek(to: kCMTimeZero)
        reproductor.play()
        
        
        
        
        
    }
    
    ///Funcion a ejecutar sobre el reproductor cuando cambie su estado
    ///es lanzado a partir de una notificación.
    func playerItem(){
        reproductor.seek(to: kCMTimeZero)
    }
}












































