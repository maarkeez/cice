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
    func showHoursSelector() {
        //let storyBoardData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        //let actionSheetVC = storyBoardData.instantiateViewController(withIdentifier: "DMDSelectorFecha") as! DMDSelectorFecha
       // actionSheetVC.modalPresentationStyle = .overCurrentContext
      //  show(actionSheetVC, sender: self)
        let storyBoardData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let actionSheetVC = storyBoardData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        
        show(actionSheetVC as! UINavigationController, sender: self)
        
    }
    
    
    
}

extension DMDCalendario : FSCalendarDelegate, FSCalendarDataSource{
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateSelected = date
        if(delegate.isHoursNeeded()){
            showHoursSelector()
        }
    }
}

extension DMDCalendario : DMDSelectorFechaDelegate {
    func didSelectHour(_ hour: Date?){
        if(hour != nil){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let strDate = dateFormatter.string(from: hour!)
            
            print("\(strDate) Hora seleccionada")
        }
    }
}
















