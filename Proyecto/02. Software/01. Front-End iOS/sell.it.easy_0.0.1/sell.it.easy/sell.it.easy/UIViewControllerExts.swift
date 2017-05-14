//
//  UIViewControllerExts.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

extension UIViewController {
    
    ///Oculta el teclado cuando se pulsa fuera de un campo de texto.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    ///Oculta el teclado.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///Muestra el menú lateral a partir una pulsación en el botón pasado como parámetro
    func mostrarMenu(_ boton: UIBarButtonItem){
        if self.revealViewController() != nil {
            boton.target = self.revealViewController()
            boton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 150
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}


