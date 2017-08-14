//
//  DMDConfirm.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit


protocol DMDConfirmDelegate {
    func confirmar()
    func cancelar()
    func getTitulo() -> String
    func getTexto() -> String
}
class DMDConfirm: UIViewController {

    //MARK: - Variables locales
    var delegate : DMDConfirmDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTituloLBL: UILabel!
    @IBOutlet weak var myTextoLBL: UILabel!
    @IBOutlet weak var myAceptarBTN: UIButton!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func myAceptarACTION(_ sender: UIButton) {
        delegate?.confirmar()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func myCancelarACTION(_ sender: UIButton) {
        delegate?.cancelar()
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Limpiar el color de fondo para que sea transparente
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        //Editar estilo botones
        //myCancelarBTN.layer.cornerRadius = 5
        //myAceptarBTN.layer.cornerRadius = 5
        
        //Editar estilo vista
        myCustomView.layer.cornerRadius = 5
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLOR.GRIS_TAB_NAV_BAR.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        //Cambiar valores según delegado
        myTituloLBL.text = delegate?.getTitulo()
        myTextoLBL.text = delegate?.getTexto()
    }
    
    ///Cancelamos la selección si se selecciona fuera de la vista.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.cancelar()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Utils
func showDMDConfirm(_ delegado: DMDConfirmDelegate){
    if let viewControler = delegado as? UIViewController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        navController.isNavigationBarHidden = true
        
        let selectorVC = viewControler.storyboard?.instantiateViewController(withIdentifier :"DMDConfirm") as! DMDConfirm
        selectorVC.delegate = viewControler as? DMDConfirmDelegate
        
        navController.viewControllers = [selectorVC]
        
        viewControler.show(navController , sender: selectorVC)
    }
}
