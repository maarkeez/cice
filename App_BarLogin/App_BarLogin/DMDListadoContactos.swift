//
//  DMDListadoContactos.swift
//  App_BarLogin
//
//  Created by cice on 3/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDListadoContactos: UITableViewController {
    
    //MARK : - Variables locales
    var contactos : [Contacto] = []
    var contacto : Contacto = [:]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //======================
        // DATOS
        //======================
        //Recuperamos el path para el plist con los contactos
        let rutaContactos = Bundle.main.path(forResource: "Contactos", ofType: "plist")
        //Asignamos los valores a un array
        contactos = NSArray(contentsOfFile: rutaContactos!) as! [Contacto]
        
        
        
        //======================
        // CELDAS
        //======================
        tableView.register(UINib(nibName: "DMDVistaMiContactoCelda", bundle:  nil ) , forCellReuseIdentifier: "VistaMiContactoCelda")
        self.title = "Mis contactos"
        
        //======================
        // BARRA DE NAVEGACION
        //======================
        //Creamos un botón en la barra de navegación que mostrará mi perfil
        let btnMiPerfil = UIButton(type: .custom)
        btnMiPerfil.setImage(UIImage(named: "brad-pitt.jpg"), for: .normal)
        btnMiPerfil.frame = CGRect(x: 0, y: 0, width: 35, height: 35 )
        btnMiPerfil.layer.cornerRadius = btnMiPerfil.frame.width / 2 //Lo convertimos en un circulo
        btnMiPerfil.layer.borderColor = CONSTANTES.COLOR.AMARILLO.cgColor
        btnMiPerfil.imageView?.contentMode = .scaleAspectFill
        btnMiPerfil.clipsToBounds = true
        
        btnMiPerfil.addTarget(self, action: #selector(muestraMiPerfilVC), for: .touchUpInside)
        
        //Creamos la variable con el botón de la barra
        let barButtonItem = UIBarButtonItem(customView: btnMiPerfil)
        navigationItem.rightBarButtonItem = barButtonItem
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaMiPerfil = tableView.dequeueReusableCell(withIdentifier: "VistaMiContactoCelda", for: indexPath) as! DMDVistaMiContactoCelda
        
        contacto = contactos[indexPath.row]
        celdaMiPerfil.InicializarIBOutlets(imagen: UIImage(named: contacto["imageProfile"]!  as! String)!, nombre: contacto["firstName"]! as! String, apellido: contacto["lastName"]! as! String)
        

        return celdaMiPerfil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func muestraMiPerfilVC(){
       muestraMiPerfilVCGlobal(navigationGlobal: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleContacto = self.storyboard?.instantiateViewController(withIdentifier: "MiPerfil") as! DMDMiPerfil
        detalleContacto.contacto = contactos[indexPath.row]
        present(detalleContacto, animated: true, completion: nil)
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

