//
//  DMDPerfilViewController.swift
//  solosView
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPerfilViewController: UIViewController {

     var arrayDiccionario : [jsonStandar] = []
    var listadoContactos : jsonStandar = [:]
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var apellidos: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    @IBOutlet weak var provincia: UILabel!
    @IBOutlet weak var fechaAlta: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ruta = Bundle.main.path(forResource: "listadoContactos", ofType: "plist")
        arrayDiccionario = NSArray(contentsOfFile: ruta!) as! [jsonStandar]
        listadoContactos = arrayDiccionario[0]
        
        imagen.image = UIImage(named: listadoContactos["imagen"]! as! String)
        
        nombre.text = listadoContactos["nombre"] as! String?
        
        apellidos.text = listadoContactos["apellidos"] as! String?
        
        telefono.text = listadoContactos["telefono"] as! String?
        
        direccion.text = listadoContactos["calle"] as! String?
        
        ciudad.text = listadoContactos["localidad"] as! String?
        provincia.text = listadoContactos["provincia"] as! String?
        fechaAlta.text = transformarFecha(fecha: listadoContactos["fechaAlta"] as! Date)
        
        imagen.layer.cornerRadius = imagen.frame.height/2
        imagen.clipsToBounds = true
        // Do any additional setup after loading the view.
        redondearEsquinas()
    }
    
    func redondearEsquinas(){
        nombre.layer.cornerRadius = 5
        apellidos.layer.cornerRadius = 5
        telefono.layer.cornerRadius = 5
        direccion.layer.cornerRadius = 5
        ciudad.layer.cornerRadius = 5
        provincia.layer.cornerRadius = 5
        fechaAlta.layer.cornerRadius = 5
        
       
        
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
