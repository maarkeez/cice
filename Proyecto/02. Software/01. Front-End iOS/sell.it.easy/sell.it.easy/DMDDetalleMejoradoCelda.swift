//
//  DMDDetalleMejoradoCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 26/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDDetalleMejoradoCelda: UITableViewCell {

    //MARK: - Variables locales
    let COLOR_ETIQUETA : UIColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
    let COLOR_DATO : UIColor = UIColor(red:0.00, green:0.48, blue:0.80, alpha:1.0)
    
    
    //MARK : - IBOutlets
    @IBOutlet weak var myViewIzquierda: UIView!
    @IBOutlet weak var myViewDerecha: UIView!
    @IBOutlet weak var myDatoIzq: UILabel!
    @IBOutlet weak var myDatoDerecha: UILabel!
    @IBOutlet weak var mylblIzq: UILabel!
    @IBOutlet weak var mylblDcha: UILabel!
    
    //MARK: - LIFE VC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myViewIzquierda.layer.cornerRadius = 2
        myViewDerecha.layer.cornerRadius = 2
        
        mylblIzq.textColor = COLOR_ETIQUETA
        mylblDcha.textColor = COLOR_ETIQUETA
        myDatoIzq.textColor = COLOR_DATO
        myDatoDerecha.textColor = COLOR_DATO
        
        //===========================
        //Funcionalidad dato izquierda
        //===========================
        addReconocedorGestos(myViewIzquierda,gesto: UITapGestureRecognizer(target: self, action: #selector(setDatoIzquierda)))
       
        //===========================
        //Funcionalidad dato derecha
        //===========================
        addReconocedorGestos(myViewDerecha,gesto: UITapGestureRecognizer(target: self, action: #selector(setDatoDerecha)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Utils
    
    ///Permite a un view reconocer una pulsación sobre él y ejecuta la acción del gesto indicado
    /// - parameter view: View que va a poder ser pulsado
    /// - parameter gesto: Gesto que define la acción a realizar en una pulsación
    func addReconocedorGestos(_ view: UIView, gesto:  UITapGestureRecognizer){
        gesto.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesto)
        view.isUserInteractionEnabled = true
    }
    
    ///Permite modificar el valor del dato contenido en el view izquierdo
    func setDatoIzquierda(){
        setDato(etiqueta: mylblIzq, dato: myDatoIzq)
    }
    ///Permite modificar el valor del dato contenido en el view derecho
    func setDatoDerecha(){
        setDato(etiqueta: mylblDcha, dato: myDatoDerecha)
    }

    ///    Muestra un alert que permite modificar el valor para un label(dato) mostrando como título el valor de otro label(etiqueta)
    /// - parameter etiqueta: Título del alert
    /// - parameter  dato: Label cuyo contenido se quiere modificar
    func setDato(etiqueta: UILabel, dato: UILabel){
        //Crear alert
        let alertVC  = UIAlertController(title: etiqueta.text, message: "Introduzca el nuevo valor", preferredStyle: .alert)
        //Añadir campo de texto para modificar el contenido
        alertVC.addTextField { (textoDato) in
            textoDato.text = dato.text
        }
        //Si aceptamos, se modifica el texto para la etiqueta dato
        alertVC.addAction(UIAlertAction(title: "Aceptar", style: .default, handler:
            {(Void) in
                dato.text = alertVC.textFields![0].text
            }
        ))
        //Si se cancela no se hace nada
        alertVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        //Indicamos al ViewController padre que presente la alerta
        padreVC?.present(alertVC, animated: true, completion: nil)
    }
    
}

//Extensión que permite a la celda recuperar el ViewController padre
extension UIView {
    ///Variable calculada para poder presentar información. Representa el primer ViewController padre encontrado
    var padreVC: UIViewController? {
        //Variable que almacenará el padre, inicializado como la propia celda
        var elementoPadre: UIResponder? = self
        //Recorremos los contenedores hasta dar un un ViewController si existe
        while elementoPadre != nil {
            //Actualizamos el valor del padre con el siguiente en la jerarquía hacia arriba
            elementoPadre = elementoPadre!.next
            //Si es un ViewController paramos y lo retornamos
            if elementoPadre is UIViewController {
                return elementoPadre as! UIViewController!
            }
        }
        //Se devuelve nil en caso de no encontrar un viewController
        return nil
    }
}
