//
//  DMDUserCell.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit


class DMDUserCell: UITableViewCell {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myId: UILabel!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myDireccion: UILabel!
    @IBOutlet weak var myTelefno: UILabel!
    @IBOutlet weak var myWeb: UILabel!
    @IBOutlet weak var myCompania: UILabel!
    
    @IBOutlet weak var myShowWebBTN: UIButton!
    
    @IBOutlet weak var myShowMapBTN: UIButton!

    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setIBOutlets(user : User){
        myId.text = "\(user.id!)"
        myNombre.text = "\(user.name!)"
        myDireccion.text = "\(user.address!.street!)"
        myTelefno.text = "\(user.phone!)"
        myWeb.text = "\(user.website!)"
        myCompania.text = "\(user.company!.name!)"
        
       
    }
    
}
