//
//  DMDLogin.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
//Para el video
import AVFoundation

class DMDLogin: UIViewController {
    
    //MARK: - Variables locales
    var reproductor: AVPlayer!
    

    @IBOutlet weak var myIniciarSesionBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Mostrar el video de fondo
        showVideoInVC()
        
        //Redondear los botones
        myIniciarSesionBTN.layer.cornerRadius = 5
        
        hideKeyboardWhenTappedAround()
        
    }

    
    //MARK: - Utils
    
    ///Permite mostrar un video de fondo, el video está almacenado en la aplicación
    func showVideoInVC() {
        
        
        let rutaVideo = Bundle.main.path(forResource: "Money30s", ofType: "mp4")
        
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
