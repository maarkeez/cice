//
//  DMDSelectorFecha.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 16/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDSelectorFechaDelegate {
    func didSelectHour(_ hour: Date?)
}

class DMDSelectorFecha: UIViewController {

    @IBOutlet weak var myCancelarBTN: UIButton!
    @IBOutlet weak var myAceptarBTN: UIButton!
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    var delegate : DMDSelectorFechaDelegate?
    var hour : Date?
    
    @IBAction func aceptarACTION(_ sender: UIButton) {
        delegate?.didSelectHour(hour)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelarACTION(_ sender: UIButton) {
        delegate?.didSelectHour(nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        hour = myDatePicker.date
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
        

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didSelectHour(nil)
        dismiss(animated: true, completion: nil)
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
