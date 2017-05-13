//
//  DMDRegistro.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 5/3/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import CoreData
class DMDRegistro: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - Variables locales
    var tiposDeUsuario = ["Usuario básico", "Organización", "Empleado"]
    //MARK: - IBOutlets
    @IBOutlet weak var myRegistro: UITextField!
    @IBOutlet weak var myApellidos: UITextField!
    @IBOutlet weak var myCorreo: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myPasswordConfirmation: UITextField!
    
    @IBOutlet weak var myTipoUsuario: UIPickerView!
    
    
    //MARK: - IBActions
    @IBAction func registrarUsuario(_ sender: Any) {
        let usuarios = UsuarioRepository.shared.findAll()
        
        for i in 0..<usuarios.count {
            Parseador.shared.listPropertiesWithValues(reflect: Mirror(reflecting: usuarios[i]))
        }
    }
    
  
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTipoUsuario.delegate=self
        self.myTipoUsuario.dataSource=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Extension pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposDeUsuario.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposDeUsuario[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            print(0)
        case 1:
            print(1)
        case 2:
            print(2)
        default:
            print("default")
        }
    }
}
