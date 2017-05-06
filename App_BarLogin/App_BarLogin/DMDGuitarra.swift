//
//  DMDGuitarra.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDGuitarra: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenAcordesGuitarra: UIImageView!
    @IBOutlet weak var myNombreAcordeLBL: UILabel!
    
    //MARK: - IBActions
    @IBAction func acordeSeleccionadoAction(_ sender: UIButton) {
        myNombreAcordeLBL.text = sender.titleLabel?.text
        asignarAcorde(sender.tag)
        
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func asignarAcorde(_ tag: Int){
        switch tag {
        case 0:
            asignarImagen("img_g_do")
        case 1:
            asignarImagen("img_g_re")
        case 2:
            asignarImagen("img_g_rem")
        case 3:
            asignarImagen("img_g_mi")
        case 4:
            asignarImagen("img_g_mim")
        case 5:
            asignarImagen("img_g_fa")
        case 6:
            asignarImagen("img_g_fasm")
        case 7:
            asignarImagen("img_g_sol")
        case 8:
            asignarImagen("img_g_la")
        case 9:
            asignarImagen("img_g_lam")
        case 10:
            asignarImagen("img_g_si")
        case 11:
            asignarImagen("img_g_sim")
            
        default:
            asignarImagen("img_mastil")
        }
    }
    
    func asignarImagen(_ nombre : String){
        myImagenAcordesGuitarra.image = UIImage(named: nombre)
    }
}
