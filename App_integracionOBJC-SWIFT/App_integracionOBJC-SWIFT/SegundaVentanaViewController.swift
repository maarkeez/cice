//
//  SegundaVentanaViewController.swift
//  App_integracionOBJC-SWIFT
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class SegundaVentanaViewController: UIViewController {

    @IBAction func mostrarSaludo(_ sender: Any) {
        mySaludoSwift.text = "Te estoy saludando desde Swift"
    }
    @IBOutlet weak var mySaludoSwift: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let person = DatosModel(firstName: "Anakin", lastName: "Soy tu padre", alias: "Darth Vader")
        print(person!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
