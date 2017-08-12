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
    
    //Textfield activo para hacer scroll
    var activeField: UITextField?
    
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
        
        registerForKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        mostrarMenu(myMenuBTN)
        
        //TODO: Borrar
        data = DummyTablaDataCG().getDummyData()
        
        myTable.dataSource = self
        myTable.delegate = self
        myTable.separatorStyle = .none
        
        myTable.register(UINib(nibName: "CeldaTexto", bundle: nil), forCellReuseIdentifier: "CeldaTexto")
        myTable.register(UINib(nibName: "CeldaFecha", bundle: nil), forCellReuseIdentifier: "CeldaFecha")
        myTable.register(UINib(nibName: "CeldaPerfil", bundle: nil), forCellReuseIdentifier: "CeldaPerfil")
        myTable.register(UINib(nibName: "CeldaCodigoBarras", bundle: nil), forCellReuseIdentifier: "CeldaCodigoBarras")
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
        let celda =  data.getCelda(indexPath.row, tabla: myTable)
        celda.selectionStyle = .none
        return celda
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

//MARK: - Extensión para tratar con los campos de texto
extension DMDTablaDinamicaCG: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    //MARK: - Utils teclado
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = myTable.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height -= keyboardSize.height
            myTable.frame = frame
            if activeField != nil {
                let rect = myTable.convert((activeField?.bounds)!, from: activeField)
                myTable.scrollRectToVisible(rect, animated: false)
            }
            UIView.commitAnimations()
        }
    }
    
    func keyboardWillBeHidden(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = myTable.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height += keyboardSize.height
            myTable.frame = frame
            UIView.commitAnimations()
        }
    }

}
