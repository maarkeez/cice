//
//  ImagenGarito.swift
//  App_GaritosMadrid
//
//  Created by cice on 31/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class ImagenGarito: UIViewController {

    //MARK: - Variables locales
    var calloutNewImage : UIImage?
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagen: UIImageView!
    //MARK: - IBActions
    
    @IBAction func cerrarVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Si tengo imagen, la pinto
        if let detalleImagen = calloutNewImage {
            myImagen.image = detalleImagen
        }
        
        
    }
    
   
}
