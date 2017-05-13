//
//  DMDMenu.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDMenu: UIViewController {

    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if revealViewController() != nil {
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }

}
