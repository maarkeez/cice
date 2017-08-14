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
    let REPRODUCTOR_TAG = 1000
    
    //MARK: - IBoutlets
    @IBOutlet weak var myIniciarSesionBTN: UIButton!
    @IBOutlet weak var myNombre: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    
    
    //MARK: - IBActions
    @IBAction func myIniciarSesionACTION(_ sender: Any) {
        
        let user = Usuario(id: nil, correo: myNombre.text, nombre: nil, apellidos: nil, password: myPassword.text, imagen: nil)
        UsuarioService.shared.login(user) { (usuario) in
            if usuario != nil && usuario?.id != nil {
                self.login(usuario!)
            }else{
                showDMDConfirm(self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Mostrar el video de fondo
        showVideoInVC()
        
        //Redondear los botones
        myIniciarSesionBTN.layer.cornerRadius = 5
        
        hideKeyboardWhenTappedAround()
        
        //Asignar delegados
        myNombre.delegate = self
        myPassword.delegate = self
        
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
    
    func login(_ usuario: Usuario){
        //Guardar el usuario en la sesión
        Session.shared.usuario = usuario
        
        //Borrar las notificaciones
        NotificationCenter.default.removeObserver(self)
        //Parar el video, se añade la tolerancia para que no tarde en pararse en segundo plano
        reproductor.seek(to: (reproductor.currentItem?.duration)!, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimePositiveInfinity)
        //Recuperar Menu VC
        let menuVC = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        present(menuVC, animated: true, completion: nil)
    }
}

//MARK: - Extensión para ser delegado del mensaje de confirmación
extension DMDLogin : DMDConfirmDelegate{
    func confirmar(){
        
    }
    func cancelar(){
        
    }
    func getTitulo() -> String{
        return "Error en el login"
    }
    
    func getTexto() -> String {
        return "No se ha podido recuperar correctamente el usuario.\n\nRevise las credenciales introducidas y su conexión a internet."
    }
}

//MARK: - Extensión para subir y bajar la ventana cuando se toca un textfield
extension DMDLogin : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateViewMoving(true, moveValue: 200)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateViewMoving(false, moveValue: 200)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func animateViewMoving (_ up: Bool, moveValue: CGFloat){
        let movement : CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.22 )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
        
    }
}

