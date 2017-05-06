//
//  API_Utils.swift
//  DiaTres
//
//  Created by CICE on 2/12/16.
//  Copyright © 2016 DMD. All rights reserved.
//

import Foundation
import UIKit

func crearPickerViewTextField(_ tag: Int, textField: UITextField, arrayString : [String], pickerDelegate: UIPickerViewDelegate, pickerDataSource: UIPickerViewDataSource){
    //Creamos un selector PickerView
    let pickerViewLocalidad = UIPickerView()
    //Lo asociamos como delegado al ViewController
    pickerViewLocalidad.delegate = pickerDelegate
    pickerViewLocalidad.dataSource = pickerDataSource
    //Al existir más de un picker view, vamos a tener que establecer el tag que se corresponde
    pickerViewLocalidad.tag = tag
    //Establecemos el picker view asociado al texto localidad
    textField.inputView = pickerViewLocalidad
    //Establecemos como texto el primer elemento del array.
    textField.text = arrayString[0]
}
