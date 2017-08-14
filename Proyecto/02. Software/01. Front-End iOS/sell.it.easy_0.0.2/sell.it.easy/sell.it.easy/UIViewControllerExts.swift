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
    
    func hideKeyboardWhenTappedAroundWithoutCancel(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    ///Oculta el teclado.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///Muestra el menú lateral a partir una pulsación en el botón pasado como parámetro
    func mostrarMenu(_ boton: UIBarButtonItem){
        if self.revealViewController() != nil {
            self.revealViewController().delegate = self
            boton.target = self.revealViewController()
            boton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 150
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    ///Permite añadir una capa gris, con transparencia, que no permite acciones al tocar.
    ///Se le asigna una etiqueta para poder borrarla posteriormente.
    func addCapaGris(_ tag: Int){
        //Crear la capa
        let vistaGris = UIView(frame: self.view.frame)
        
        //Asignar colores, transparencia y no permitir acciones al tocar
        vistaGris.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        vistaGris.alpha = CGFloat(0.5)
        vistaGris.isUserInteractionEnabled = false
        
        //Asignar un tag para eliminarla posteriormente
        vistaGris.tag = tag
        
        //Añadir la capa a la vista sobre el resto de las capas
        self.view.addSubview(vistaGris)
    }
    
    ///Permite borrar una capa de la vista a partir de su etiqueta
    func removeCapa(_ tag: Int){
        if let vistaGris = self.view.viewWithTag(tag) {
            vistaGris.removeFromSuperview()
        }
    }
}

//MARK: - Extensión para ser delegados del menú
extension UIViewController : SWRevealViewControllerDelegate {
   
    ///Función para que el menú lateral deshabilite la interacción con la ventana principal y superponga una capa gris
    ///Si la ventana principal se empuja hacia la derecha, se quedará en gris
    ///Cuando vuelva a la izquierda se eliminará la capa gris.
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition){
        if(position == .right) {
            self.view.isUserInteractionEnabled = false
            addCapaGris(999)
        } else {
            self.view.isUserInteractionEnabled = true
            removeCapa(999)
        }
    }
    
}



