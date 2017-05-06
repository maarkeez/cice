//
//  DMDDetalleTareaCelda.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDDetalleTareaCelda: UITableViewCell {

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenTarea: UIImageView!
    @IBOutlet weak var myTexto: UILabel!
    @IBOutlet weak var myIconoTarea: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIBOutlets(texto : String?, imagenFondo: UIImage?, imagenTarea : UIImage){
        myImagenTarea.image = imagenFondo
        myTexto.text = texto
        myIconoTarea.image = imagenTarea
    }
    
}
