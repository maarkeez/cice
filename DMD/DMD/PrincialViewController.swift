//
//  PrincipalViewController.swift
//  DMD
//
//  Created by CICE on 16/12/16.
//  Copyright © 2016 David. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {
    
    //MARK: - Variables locales globales
    var currentValue : Int = 50
    var targetValue : Int  = 0
    var currentRound : Int = 0
    var puntuacionTotal : Int = 0
    

    //MARK: - IBOutlet
    @IBOutlet weak var myTargetValue: UILabel!
    @IBOutlet weak var myPuntuacionLbl: UILabel!
    @IBOutlet weak var myRondaLbl: UILabel!
    @IBOutlet weak var myCustomSlider: UISlider!
    
    
    //MARK: - IBActions
    // Botón Púlsame!
    @IBAction func muestraPuntuacionACTION(_ sender: AnyObject) {
        //Variables locales
        
        //Calculamos la diferencia
        let diferencia = abs(targetValue - currentValue)
        //Calculamos los puntos de la tirada
        var puntuacion = 100 - diferencia
        
        
        
        
        let titleData : String
        if diferencia == 0 {
            titleData = "Perfecto!"
            puntuacion += 100
        }else if diferencia < 5{
            titleData = "Casi das en el blanco!"
            puntuacion += 50

        }else if diferencia < 10 {
            titleData = "Tienes que mejorar!"
            puntuacion += 10
        }else{
            titleData = "Lo siento, esto no es lo tuyo"
        }
        
        //Actualizamos el valor de la puntuación global
        puntuacionTotal += puntuacion
        //Definimos el mensaje a mostrar
        let messageData = "Enohorabuena! has conseguido \(puntuacion)"
        
        //Construimos la alerta para mostrar el mensaje
        let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
        //Añadimos el botón a la alerta
        alertVC.addAction(UIAlertAction(title: "Asombroso", style: .default, handler: {
            Void in
            self.initNewRound()
        }))
        //Mostramos la alerta
        present(alertVC,animated: true,completion: nil)
        
      
        
    }
    
    //Tenemos que ajustar el valor del slider entre 0 y 100, Y el valor a 50
    @IBAction func sliderMovidoACTION(_ sender: UISlider) {
        //print("El valor del slider es \(sender.value)")
        currentValue = Int(sender.value)
        
    }
    
    
    @IBAction func resetJuegoACTION(_ sender: AnyObject) {
       iniciarNuevoJuego()
        
    }
    
    
    //MARK: - LIFEVC
    override func viewDidLoad() {
        super.viewDidLoad()
        initNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Utils
    func initNewRound(){
        
        currentValue = Int(self.myCustomSlider.maximumValue/2)
        //Numero entre 0 y 100:
        targetValue = Int(arc4random_uniform(101))
        //Damos el nuevo valor al Slider
        myCustomSlider.value = Float(currentValue)
        //Nueva ronda
        currentRound += 1
        
        actualizaLBL()
    }
    
    func actualizaLBL(){
        
        myRondaLbl.text = String(currentRound)
        myTargetValue.text = String(targetValue)
        myPuntuacionLbl.text = String(puntuacionTotal)
    }
    
    func iniciarNuevoJuego(){
        //Reseteamos las variables
        puntuacionTotal = 0
        currentRound = 0
        //Las inicializamos
        initNewRound()
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
