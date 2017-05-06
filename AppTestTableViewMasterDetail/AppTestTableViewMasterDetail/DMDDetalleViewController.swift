//
//  DMDDetalleViewController.swift
//  AppTestTableViewMasterDetail
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDDetalleViewController: UIViewController {

    //MARK: - Variables Locales
    var detalleData : [String : String]!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imagenContacto: UIImageView!
    @IBOutlet weak var nombreCompleto: UILabel!
    @IBOutlet weak var bibliografia: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    @IBOutlet weak var estado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Damos valor a las etiquetas a partir del diccionario cargado desde la clase lista
        nombreCompleto.text = (detalleData["nombre"])! + " " + (detalleData["apellido"])!
        bibliografia.text = detalleData["biografia"]
        email.text = detalleData["email"]
        telefono.text = detalleData["telefono"]
        direccion.text = detalleData["direccion"]
        ciudad.text = detalleData["ciudad"]
        estado.text = detalleData["estado"]
        
        let imagenCustom = UIImage(named: detalleData["imagenContacto"]!)
        imagenContacto.image = imagenCustom
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
