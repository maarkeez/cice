//
//  DMDSegundaVentanaVC.swift
//  DiaTres
//
//  Created by CICE on 2/12/16.
//  Copyright © 2016 DMD. All rights reserved.

import UIKit

class DMDSegundaVentanaVC: UIViewController {
    
    
    //MARK: - Variables locales globales
    var arrayNombreAlimentos = ["Mozzarella","Gorgonzola","Manchego","Provologne"]
    var arrayDescAlimentos = ["Mozzarella ............................. bla bla bla bla ........................","Gorgonzola ............................. bla bla bla bla ........................","Manchego ............................. bla bla bla bla ........................","Provologne ............................. bla bla bla bla ........................"]
    var arrayImgAlimentos = ["mozarella.jpeg","pikachu.jpg","pikachu.jpg","provologne.jpeg"]
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTitulo: UILabel!
    @IBOutlet weak var myTexto: UITextView!
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myAlimentoPV: UIPickerView!
    
    //MARK: - IBActions
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        //Lo hemos convertido en delegado por la UI (Arrastrando sobre el View Controller)
        // Aunque lo asignamos de nuevo en el código para ver cómo se hace:
        myAlimentoPV.delegate = self
        myAlimentoPV.dataSource = self
        
        
        // Do any additional setup after loading the view.
        inicializar(row: 0)
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

    func inicializar(row: Int){
        myTitulo.text = arrayNombreAlimentos[row]
        myTexto.text = arrayDescAlimentos[row]
        myImagen.image = UIImage(named:arrayImgAlimentos[row])!
    }
}//MARK: - FIN DE LA CLASE

extension DMDSegundaVentanaVC : UIPickerViewDelegate, UIPickerViewDataSource{
    
    //Número de secciones, es decir, número de arrays que tienen distintos tipos de información
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Número de datos que contiene el array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayNombreAlimentos.count//Array de datos
    }
    //Nombre de cada línea
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayNombreAlimentos[row]
    }
    //Espaciado entre elementos del picker view
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    //Acción a realizar una vez pulsada una línea
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            inicializar(row:row)
        
    }
    
}
