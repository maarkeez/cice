//
//  ViewController.swift
//  AppTableViewSolos
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - Variables locales
    var myArrayMesesUno = ["Enero","Febrero","Marzo"]
    var myArrayMesesDos = ["Abril","Mayo","Junio"]
    var myArrayMeses3 = ["Julio","Agosto","Septiembre"]
    var myArrayMeses4 = ["Octubre","Noviembre","Diciembre"]

    //MARK: - IBOutlet
    @IBOutlet weak var myTableViewCustom: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTableViewCustom.register(UITableViewCell.self, forCellReuseIdentifier: "Celda")
        myTableViewCustom.delegate = self
        myTableViewCustom.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK: - Delegado

extension ViewController :  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return myArrayMesesUno.count
        case 1:
            return myArrayMesesDos.count
        case 2:
            return myArrayMeses3.count
        case 3:
            return myArrayMeses4.count
        default:
           return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Invierno"
        case 1:
            return "Primavera"
        case 2:
            return "Verano"
        case 3:
            return "Otoño"
        default:
            return "Undefined"
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableViewCustom.dequeueReusableCell(withIdentifier: "Celda")!
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = myArrayMesesUno[indexPath.row]
        case 1:
            cell.textLabel?.text = myArrayMesesDos[indexPath.row]
        case 2:
            cell.textLabel?.text = myArrayMeses3[indexPath.row]
        case 3:
            cell.textLabel?.text = myArrayMeses4[indexPath.row]
        default:
            cell.textLabel?.text = myArrayMesesUno[indexPath.row]
        }
        
        return cell
    }
}
