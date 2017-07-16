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
    var indexItemSelected : Int?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myContainer: UIView!
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostrarMenu(myMenuBTN)
        data = DummyTablaDataCG().getDummyData()
        
        myTable.dataSource = self
        myTable.delegate = self
        myTable.separatorStyle = .none
        
        myTable.register(UINib(nibName: "celdaTexto", bundle: nil), forCellReuseIdentifier: "celdaTexto")
        myTable.register(UINib(nibName: "celdaFecha", bundle: nil), forCellReuseIdentifier: "celdaFecha")
    }

    
    //MARK: - Utils
    func hideSearchBarAnimated(){
        UIView.animate(withDuration: 0.2, animations: {
            self.hideSearchBar()
        })
    }
    func hideSearchBar() {
        mySearch.isHidden = true
        myTable.frame = CGRect(x: 0, y: 0, width: myContainer.frame.width, height: myContainer.frame.height)
    }
    
    func showSearchBarAnimated(){
        UIView.animate(withDuration: 0.2, animations: {
            self.mySearch.isHidden = false
            self.myTable.frame = CGRect(x: 0, y: 44, width: self.myContainer.frame.width, height: self.myContainer.frame.height)
            
        })
    }
    
    func didSelectItem(_ index: Int){
        indexItemSelected = index
    }
    
    func getSelectedItem() -> DMDCeldaCGDelegate?{
        if let index = indexItemSelected{
             return data.listaItems[index]
        }
        return nil
    }
    
    func updateSeledtedItem(_ item: DMDCeldaCGDelegate){
        if let index = indexItemSelected{
            data.listaItems[index] = item
            myTable.reloadData()
        }
    }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y <= 0 ){
            if(mySearch.isHidden){
                showSearchBarAnimated()
            }
        }else{
            if(!mySearch.isHidden){
                hideSearchBarAnimated()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem(indexPath.row)
        if getSelectedItem() is DMDCeldaFecha {
            showCalendar()
        }
    }
}

//MARK: - Extensión para mostrar el calendario
extension  DMDTablaDinamicaCG: DMDCalendarioDelegate {
    
    func showCalendar(){
        let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "DMDCalendario") as! DMDCalendario
        calendarVC.delegate = self
        calendarVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func didSelectDate(_ date: Date){
        let itemSelected = getSelectedItem()
        
        if let item = itemSelected as? DMDCeldaFecha {
            item.fecha = date
            updateSeledtedItem(item)
        }
        
    }
    
    func isHoursNeeded() -> Bool {
        return true
    }
}
