//
//  DMDSelector.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDSelectorDelegate {
    func didSelect(_ indexSelected: Int?)
    func getOptions() -> [String]
}

class DMDSelector: UIViewController {
    
    //MARK: - Variables locales
    var delegate : DMDSelectorDelegate?

    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTituloLBL: UILabel!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myAceptarBTN: UIButton!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func myAceptarACTION(_ sender: UIButton) {
        let row = myPicker.selectedRow(inComponent: 0)
        delegate?.didSelect(row)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func myCancelarACTION(_ sender: UIButton) {
        delegate?.didSelect(nil)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - LIFE VC
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
        
        //Dar valores al selector
        myPicker.delegate = self
        myPicker.dataSource = self
    }

    ///Cancelamos la selección si se selecciona fuera de la vista.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didSelect(nil)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Funciones para el selector
extension DMDSelector : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (delegate?.getOptions().count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate?.getOptions()[row]
    }
}

//MARK: - Utils
func showDMDSelector(_ delegado: DMDSelectorDelegate){
    if let viewControler = delegado as? UIViewController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        navController.isNavigationBarHidden = true
        
        let selectorVC = viewControler.storyboard?.instantiateViewController(withIdentifier :"DMDSelector") as! DMDSelector
        selectorVC.delegate = viewControler as? DMDSelectorDelegate
        
        navController.viewControllers = [selectorVC]
        
        viewControler.show(navController , sender: selectorVC)
    }
}






