//
//  DMDPerfilTVC.swift
//  App_XIB_vs_CELL
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPerfilTVC: UITableViewController {
    
    //MARK: - Variables locales
    var arrayTexto = ["1 . - Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.","2 . - Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.","3 . - Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registramos el XIB con la info de la celda
        //nibName: Nombre del .XIB que hemos creado
        //forCellReuseIdentifier: identificador de la celda.
        tableView.register(UINib(nibName: "DMDPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "PerfilCustomCell")
        tableView.register(UINib(nibName: "DMDCeldaTipoUnoTVCell", bundle: nil), forCellReuseIdentifier: "CeldaTipoUnoTVCell")
        tableView.register(UINib(nibName: "DMDCeldaTipoDos", bundle: nil), forCellReuseIdentifier: "CeldaTipoDos")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1: return 3
            
        default:
            return arrayTexto.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let perfilCell = tableView.dequeueReusableCell(withIdentifier: "PerfilCustomCell", for: indexPath) as! DMDPerfilCustomCell
            perfilCell.fondoPerfil.image = UIImage(named: "fondo.png")
            perfilCell.imagenPerfil.image = UIImage(named: "nikename.png")
            perfilCell.username.text = "@maarkeez"
            perfilCell.nombre.text = "David Márquez Delgado"
            perfilCell.biografia.text = "Soy David Márquez y trabajo en British Telecom Global Services"
            perfilCell.numeroPublicaciones.text = "2456"
            perfilCell.numeroSeguidores.text = "3455"
            perfilCell.numeroSeguidos.text = "5112"
            
            
            perfilCell.botonEmail.addTarget(self, action: #selector(self.muestraMail(_:)), for: .touchUpOutside)
            return perfilCell
            
        case 1:
            let perfilCell = tableView.dequeueReusableCell(withIdentifier: "CeldaTipoUnoTVCell", for: indexPath) as! DMDCeldaTipoUnoTVCell
            
            return perfilCell
        default:
            let perfilCell = tableView.dequeueReusableCell(withIdentifier: "CeldaTipoDos", for: indexPath) as! DMDCeldaTipoDos
            perfilCell.pruebadinamica.text = arrayTexto[indexPath.row]
            
            
            
            return perfilCell
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 390
        default:
            //tamaño dinámico
            return UITableViewAutomaticDimension
        }
    }
    //Es necesario este método para que funcione el tamaño dinámico
   override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func muestraMail(_ sender : UIButton   ){
        let alertVC = UIAlertController(title: "Hola", message: "Andres", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil ))
        present(alertVC,animated: true, completion:nil)
    
        
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
