//
//  Internacionalizacion.swift
//  App_SocialNetwork
//
//  Created by cice on 31/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class Internacionalizacion: UIViewController {

    //MARK: - Variables locales
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myLBLName: UILabel!
    @IBOutlet weak var myLBLCurrency: UILabel!
    @IBOutlet weak var myLBLDate: UILabel!
    @IBOutlet weak var myLBLLastName: UILabel!
    @IBOutlet weak var myLBLNumber: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
    
    
    //MARK: - IBActions
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        getValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        present(showAlert(NSLocalizedString("GOOD_MORNING", comment: ""), mensaje: NSLocalizedString("MESSAGE_DATA", comment: ""), tituloAccion: NSLocalizedString("TITLE_DATA", comment: "")), animated: true, completion: nil) 
    }
    
    //MARK: - Utilis
    func getValues(){
        myLBLName.text = "David"
        myLBLCurrency.text = "€"
        myLBLDate.text = "31/03/2017"
        myLBLLastName.text = "Márquez Delgado"
        myLBLNumber.text = "652652652"
        myImage.image = UIImage(named: "hola.png")
    }

}
