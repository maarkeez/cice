//
//  DMDTablaDinamicaCG.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDTablaDinamicaCG: UIViewController {

    //MARK: - Variables locales
    var data : DMDTablaDataCG!
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mostrarMenu(myMenuBTN)
        data = DummyTablaDataCG.shared.getDummyData()
        
        myTable.dataSource = self
        myTable.delegate = self
        
        myTable.register(UINib(nibName: "celdaTexto", bundle: nil), forCellReuseIdentifier: "celdaTexto")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //MARK: - Utils

}

//MARK: - Extensión para mostrar el listado de productos
extension DMDTablaDinamicaCG: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data.getCelda(indexPath.row, tabla: myTable)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data.getHeightForRowAt(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        return data.getAcciones(indexPath.row)
    }
}
