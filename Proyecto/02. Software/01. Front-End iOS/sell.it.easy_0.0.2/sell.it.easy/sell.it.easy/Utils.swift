//
//  Utils.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static let shared = Utils()
    
    
    func getImagen(_ texto: String?) -> UIImage?{
        var imagen : UIImage? = nil
        if let imagenStr = texto{
            let dataDecoded = Data(base64Encoded: imagenStr)
            if let datos = dataDecoded {
                imagen = UIImage(data: datos)!
            }
        }
        return imagen
    }
    
    func getTexto(_ imagen: UIImage?) -> String?{
        if let img = imagen {
            let imagenData = UIImagePNGRepresentation(img)!
            let imagenString = imagenData.base64EncodedString()
            return imagenString
        }
        return nil
    }
    
    func comprimirImagen(_ imagen: UIImage) -> UIImage{
        let imageDataCompress = UIImageJPEGRepresentation(imagen, 0.2)
        if let data = imageDataCompress {
            if let image = UIImage(data: data){
                return image
            }
        }
        return imagen
    }

}


