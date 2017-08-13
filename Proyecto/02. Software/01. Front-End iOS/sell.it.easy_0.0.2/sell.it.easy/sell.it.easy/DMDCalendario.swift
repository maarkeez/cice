//
//  DMDCalendario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import FSCalendar

protocol DMDCalendarioDelegate {
    func didSelectDate(_ date: Date)
    func isHoursNeeded() -> Bool
}

class DMDCalendario: UIViewController {
    
    //MARK: - Variables locales
    var dateSelected : Date?
    var delegate : DMDCalendarioDelegate!
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCalendar: FSCalendar!
    
    //MARK: - IBActions
    @IBAction func myConfirmarACTION(_ sender: Any) {
        
        if let date = dateSelected{
            delegate.didSelectDate(date)
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCalendar.dataSource = self
        myCalendar.delegate = self
        
    }
    
    //MARK: - Utils
    func showHoursSelector2() {
        //let storyBoardData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        //let actionSheetVC = storyBoardData.instantiateViewController(withIdentifier: "DMDSelectorFecha") as! DMDSelectorFecha
       // actionSheetVC.modalPresentationStyle = .overCurrentContext
      //  show(actionSheetVC, sender: self)
        let storyBoardData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let actionSheetVC = storyBoardData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        
        show(actionSheetVC as! UINavigationController, sender: self)
        
    }
    
    func showHoursSelector(){
        let navController = UINavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        navController.isNavigationBarHidden = true
        
        let selectorFechaVC = self.storyboard?.instantiateViewController(withIdentifier :"DMDSelectorFecha") as! DMDSelectorFecha
        selectorFechaVC.delegate = self
        
        navController.viewControllers = [selectorFechaVC]
       
        self.show(navController , sender: self)
        
    }
    
    
    
}

extension DMDCalendario : FSCalendarDelegate, FSCalendarDataSource{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateSelected = date
        if(delegate.isHoursNeeded()){
            showDMDSelectorFecha(self)
        }
    }
}

extension DMDCalendario : DMDSelectorFechaDelegate {
    func didSelectHour(_ date: Date?){
        if let fecha = date {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: fecha)
            let minutes = calendar.component(.minute, from: fecha)
            
            //PRE: Se ha seleccionado una fecha
            dateSelected = calendar.date(bySettingHour: hour, minute: minutes, second: 0, of: dateSelected!)
        }
    }
}
















