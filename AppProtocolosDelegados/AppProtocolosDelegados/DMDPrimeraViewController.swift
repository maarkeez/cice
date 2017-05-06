//
//  DMDPrimeraViewController.swift
//  AppProtocolosDelegados
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPrimeraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DMDSegundaViewController
        destinationVC.myDMDDelegado = self
        
    }
}


extension DMDPrimeraViewController : DMDSegundaViewControllerDelegate{
    func dmdSegundaBotonVerdaderoPulsado() {
        print("El botón verdadero ha sido pulsado")
    }
    func dmdSegundaBotonFalsoPulsado() {
        print("El botón falso ha sido pulsado")
    }
}
