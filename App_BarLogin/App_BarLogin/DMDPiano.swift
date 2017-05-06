//
//  DMDPiano.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPiano: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenAcordePiano: UIImageView!
    @IBOutlet weak var myAcordePianoLBL: UILabel!
    
    @IBAction func acordePulsado(_ sender: UIButton) {
        myAcordePianoLBL.text = sender.titleLabel?.text
        asignarAcorde(sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func asignarAcorde(_ tag: Int){
        switch tag {
        case 0:
            asignarImagen("img_p_do")
        case 1:
            asignarImagen("img_p_re")
        case 2:
            asignarImagen("img_p_rem")
        case 3:
            asignarImagen("img_p_mi")
        case 4:
            asignarImagen("img_p_mim")
        case 5:
            asignarImagen("img_p_fa")
        case 6:
            asignarImagen("img_p_fasm")
        case 7:
            asignarImagen("img_p_sol")
        case 8:
            asignarImagen("img_p_la")
        case 9:
            asignarImagen("img_p_lam")
        case 10:
            asignarImagen("img_p_si")
        case 11:
            asignarImagen("img_p_sim")
            
        default:
            asignarImagen("img_piano")
        }
    }
    
    func asignarImagen(_ nombre : String){
        myImagenAcordePiano.image = UIImage(named: nombre)
    }
   

}
