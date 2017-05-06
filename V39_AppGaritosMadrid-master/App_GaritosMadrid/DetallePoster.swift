//
//  DetallePoster.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class DetallePoster: UITableViewCell {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myTexto: UILabel!
    @IBOutlet weak var myAnio: UILabel!
    @IBOutlet weak var myId: UILabel!
    @IBOutlet weak var myTipo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setIBOutlets(poster: Poster){
        print("Pintando poster:\(poster.Title)")
        myTexto.text = poster.Title
        myAnio.text = poster.Year
        myId.text = poster.imdbID
        myTipo.text = poster.Type
        myImagen.kf.setImage(with: URL(string: poster.Poster),
                           placeholder: #imageLiteral(resourceName: "placehoder"),
                           options: nil,
                           progressBlock: nil,
                           completionHandler: nil
        )
        
        
    }
    
}
