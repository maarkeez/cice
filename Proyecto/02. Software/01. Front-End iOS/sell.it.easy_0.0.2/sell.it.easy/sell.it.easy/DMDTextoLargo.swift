//
//  DMDTextoLargo.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDTextoLargoDelegate {
    func setTexto(_ texto: String)
    func getTexto() -> String
    func getTitulo() -> String
}

class DMDTextoLargo: UIViewController {
    //MARK: - Variables locales
    var delegate : DMDTextoLargoDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTituloLBL: UILabel!
    @IBOutlet weak var myTexto: UITextView!
    @IBOutlet weak var myAceptarBTN: UIButton!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func myAceptarACTION(_ sender: UIButton) {
        delegate?.setTexto(myTexto.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func myCancelarACTION(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Limpiar el color de fondo para que sea transparente
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        //Editar estilo botones
        myCancelarBTN.layer.cornerRadius = 5
        myAceptarBTN.layer.cornerRadius = 5
        
        //Editar estilo vista
        myCustomView.layer.cornerRadius = 5
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLOR.GRIS_TAB_NAV_BAR.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        //Dar valores al texto y titulo
        myTituloLBL.text = delegate?.getTitulo()
        myTexto.text = delegate?.getTexto()
        
        //Mostrar el teclado
        myTexto.becomeFirstResponder()
    }
    ///Cancelamos la selección si se selecciona fuera de la vista.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Utils
func showDMDTextoLargo(_ delegado: DMDTextoLargoDelegate){
    if let viewControler = delegado as? UIViewController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        navController.isNavigationBarHidden = true
        
        let selectorVC = viewControler.storyboard?.instantiateViewController(withIdentifier :"DMDTextoLargo") as! DMDTextoLargo
        selectorVC.delegate = viewControler as? DMDTextoLargoDelegate
        
        navController.viewControllers = [selectorVC]
        
        viewControler.show(navController , sender: selectorVC)
        
    }
}
