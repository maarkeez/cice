//
//  DMDListaIconos.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit


class DMDListaIconos: UICollectionViewController {
    
    var listaIconos : [Contacto] = []
    var cabeceraDescripcionDeLaTarea : String?
    var indiceTarea : Int? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIcono("img_icono_amor",title: "Amor")
         setIcono("img_icono_amigos",title: "Amigos")
         setIcono("img_icono_archivos",title: "Archivos")
         setIcono("img_icono_compra",title: "Compra")
         setIcono("img_icono_deportes",title: "Deportes")
         setIcono("img_icono_economia",title: "Economia")
        setIcono("img_icono_fechas",title: "Fechas")
        setIcono("img_icono_ideas",title: "Ideas")
        setIcono("img_icono_lugares",title: "Lugares")
        setIcono("img_icono_musica",title: "Musica")
        setIcono("img_icono_vacaciones",title: "Vacaciones")
        setIcono("img_icono_webs",title: "Webs")
        setIcono("img_no_icon",title: "Sin definir")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listaIconos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconoCelda", for: indexPath) as! DMDIconoCelda
        
        let iconoCustom = listaIconos[indexPath.row]
        if let iconoDes = iconoCustom[CONSTANTES.USER_DEFAULTS.KEY_ICONO_TAREA]{
            cell.myIconoImagen.image = UIImage(named: iconoDes as! String)
            
        }
        
        if let textoDes = iconoCustom[CONSTANTES.USER_DEFAULTS.KEY_TITULO_ICONO_TAREA]{
            cell.myTextoCelda.text = textoDes as! String
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cabeceraCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CabeceraDescripcion", for: indexPath) as! DMDCabeceraDescripcion
        cabeceraCell.myDescripcionTareaLBL.text = cabeceraDescripcionDeLaTarea
        return cabeceraCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tareasManager.fotoTarea[indiceTarea!][CONSTANTES.USER_DEFAULTS.KEY_ICONO_TAREA] = listaIconos[indexPath.row][CONSTANTES.USER_DEFAULTS.KEY_ICONO_TAREA]
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setIcono(_ key: String, title: String){
     listaIconos.append([CONSTANTES.USER_DEFAULTS.KEY_ICONO_TAREA:key,CONSTANTES.USER_DEFAULTS.KEY_TITULO_ICONO_TAREA : title])
    }
    
    
}
