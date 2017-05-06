//
//  DMDTerceraVC.swift
//  DiaTres
//
//  Created by CICE on 2/12/16.
//  Copyright © 2016 DMD. All rights reserved.
//

import UIKit

class DMDTerceraVC: UIViewController {

    //MARK: - Variables locales globales
    var arrayLocalidad = ["Salamanca","La Latina","Centro","Fuencarral"]
    var arrayCP = ["280001","280002","28003","28004"]
    var arrayPrioridad = ["ALTA","MEDIA","BAJA"]
    var arrayImagenes = ["mozarella.jpeg","pikachu.jpg","pikachu.jpg","provologne.jpeg"]
    //MARK: - IBOutlets
    
    @IBOutlet weak var myText1: UITextField!
    @IBOutlet weak var myText2: UITextField!
    @IBOutlet weak var myText3: UITextField!
    @IBOutlet weak var myImage1: UIImageView!
    
    //MARK: - IBActions
    
    
    //MARK: - LIFE VC
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        crearPickerViewTextField(1,textField:myText1,arrayString: arrayLocalidad,pickerDelegate: self,pickerDataSource: self)
        crearPickerViewTextField(2,textField:myText2,arrayString: arrayCP,pickerDelegate: self,pickerDataSource: self)
        crearPickerViewTextField(3,textField:myText3,arrayString: arrayPrioridad,pickerDelegate: self,pickerDataSource: self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Utils
   

}//MARK: - Fin de la clase


extension DMDTerceraVC : UIPickerViewDelegate, UIPickerViewDataSource{
    
    //Número de secciones, es decir, número de arrays que tienen distintos tipos de información
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Número de datos que contiene el array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var toReturn = 0
        switch pickerView.tag {
        case 1:
            toReturn = arrayLocalidad.count
        case 2:
            toReturn = arrayCP.count
        case 3:
            toReturn = arrayPrioridad.count
        default:
            toReturn = 0
        }
        return toReturn
    }
    //Nombre de cada línea
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var toReturn = ""
        switch pickerView.tag {
        case 1:
            toReturn = arrayLocalidad[row]
        case 2:
            toReturn = arrayCP[row]
        case 3:
            toReturn = arrayPrioridad[row]
        default:
            toReturn = ""
        }
        return toReturn
    }
    //Espaciado entre elementos del picker view
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    //Acción a realizar una vez pulsada una línea
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            myText1.text = arrayLocalidad[row]
            myImage1.image = UIImage(named: arrayImagenes[row])
        case 2:
            myText2.text = arrayCP[row]
            myImage1.image = UIImage(named: arrayImagenes[row])
        case 3:
            myText3.text = arrayPrioridad[row]
            myImage1.image = UIImage(named: arrayImagenes[row])
        default:
            print("")
            
        }
        
    }
    
}
