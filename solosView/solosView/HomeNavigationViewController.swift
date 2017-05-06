//
//  HomeNavigationViewController.swift
//  solosView
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UINavigationController {
    
    var botonPersonalizado = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.botonPersonalizado.isHidden = false //ocultar
        //Asignamos la imagen
        botonPersonalizado.setImage(UIImage(named:"button.jpg"), for: UIControlState() )
        //Damos las medidas
        botonPersonalizado.frame = CGRect(origin: CGPoint.zero, size: CGSize(width:44.0, height:44.0))
        //Lo centraamoos
        botonPersonalizado.center = CGPoint(x: self.view.bounds.width - 40.0, y: self.view.bounds.height - 100.0)
        //Redondeamos las esquinas
        botonPersonalizado.layer.cornerRadius = botonPersonalizado.frame.width / 2
        //Rellenamos el contenido con la imagen
        botonPersonalizado.imageView?.contentMode = .scaleToFill
        //Lo ajustamos
        botonPersonalizado.clipsToBounds = true
        //Lo asignamos al viewController cuando click
        botonPersonalizado.addTarget(self, action: #selector(self.showPerfil), for: .touchUpInside)
        
        self.view.addSubview(botonPersonalizado)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mostramos la ventana que queremos, vinculandola a través del storyboard
    func showPerfil() {
        
        let perfilVC = storyboard?.instantiateViewController(withIdentifier: "Perfil") as! DMDPerfilViewController
        //Como soy el navigation, presento directamente.
        self.pushViewController(perfilVC, animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
