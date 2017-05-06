//
//  DetalleFoto.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import Kingfisher

class DetalleFoto: UITableViewCell {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myFoto: UIImageView!
    @IBOutlet weak var myTitulo: UILabel!
    @IBOutlet weak var myThumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIBOutlets(foto: Placeholder){
        print("Pintando foto:\(foto.title)")
        myTitulo.text = foto.title
        myFoto.kf.setImage(with: URL(string: foto.url),
                           placeholder: #imageLiteral(resourceName: "placehoder"),
                           options: nil,
                           progressBlock: nil,
                           completionHandler: nil
        )
        
        myThumb.kf.setImage(with: URL(string: foto.thumbnailUrl),
                            placeholder: #imageLiteral(resourceName: "placehoder"),
                            options: nil,
                            progressBlock: nil,
                            completionHandler: nil
        )
    }
    
}
