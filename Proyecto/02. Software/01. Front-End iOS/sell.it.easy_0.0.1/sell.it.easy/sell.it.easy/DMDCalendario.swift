//
//  DMDCalendario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import FSCalendar

class DMDCalendario: UIViewController {
    
    @IBOutlet weak var myCalendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()

        myCalendar.dataSource = self
        myCalendar.delegate = self
        
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

}

extension DMDCalendario : FSCalendarDelegate, FSCalendarDataSource{
        
    
}
















