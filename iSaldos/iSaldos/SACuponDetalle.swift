//
//  SACuponDetalle.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SACuponDetalle: UITableViewController {

    //MARK: - Variables locales
    var cupon : SAPromocionesModel?
    var detalleImagen : UIImage?
    
    //MARK: - Variables CodigoBarras
    var qrData : String?
    var imageGroupTag = 3
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoMovil: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myTelefonoFijo: UILabel!
    @IBOutlet weak var myWebURL: UILabel!
    
    @IBOutlet weak var myIdActividadAsociado: UILabel!
    
    
    //MARK: - IBActions
    
    @IBAction func muestraBarCodeACTION(_ sender: UIButton) {
        
        
        
        let customBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        
        customBackground.backgroundColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customBackground.alpha = 0.0
        customBackground.tag = imageGroupTag
        
        let customBackANIMATION = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { 
            customBackground.alpha = 0.5
            self.view.addSubview(customBackground)
        }
        
        customBackANIMATION.startAnimation()
        customBackANIMATION.addCompletion { _ in
            self.muestraImagenBarCode()
        }
        
    }
    
    @IBAction func muestraActionSheetPersonalizado(_ sender: UIBarButtonItem) {
        
        let storyBoardData = UIStoryboard(name: "ActionSheetHistoryBoard", bundle: nil)
        let actionSheetVC = storyBoardData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        
        show(actionSheetVC as! UINavigationController, sender: self)
        
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Indicar tamaños dinámicos para toda la tabla.
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let imagen = detalleImagen {
            myImagen.image = imagen
        }
        if let cupon = cupon {
            myNombre.text = cupon.nombre
            myFecha.text = cupon.fechaFin
            myMasInformacion.text = cupon.masInformacion
            myDescripcionAsociado.text = cupon.asociado?.descripcion
            myDireccionAsociado.text = cupon.asociado?.direccion
            myTelefonoMovil.text = cupon.asociado?.telefonoMovil
            myEmail.text = cupon.asociado?.mail
            
            myWebURL.text = cupon.asociado?.web
            myTelefonoFijo.text = cupon.asociado?.telefonoFijo
            myIdActividadAsociado.text = cupon.asociado?.idActividad
            qrData = cupon.asociado?.idActividad
        }
        

        
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

    //MARK: - Utils
    func muestraImagenBarCode(){
        if myIdActividadAsociado.text == qrData {
            let anchoImagen = self.view.frame.width / 1.5
            let altoImagen = self.view.frame.height / 3.0
            let x = self.view.frame.width / 2 - anchoImagen / 2
            let y = self.view.frame.height / 2 - altoImagen / 2
            
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: anchoImagen, height: altoImagen))
            
            
            imageView.contentMode = .scaleAspectFit
            imageView.tag = imageGroupTag
            imageView.image = getQRImage(from: myIdActividadAsociado.text!)
            self.view.addSubview(imageView)
        }else{
            print("Error mostrando el código de barras")
        }
    }
    
    func getQRImage(from: String) -> UIImage{
        let data = from.data(using: .ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator") //Filtro propio de Apple
        filter?.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: filter!.outputImage!)
        
    }
   
}
