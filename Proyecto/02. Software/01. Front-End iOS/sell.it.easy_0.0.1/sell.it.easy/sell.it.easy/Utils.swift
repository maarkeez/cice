//
//  Utils.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit


func mostrarMenu(_ viewController: UIViewController, boton: UIBarButtonItem){
    if viewController.revealViewController() != nil {
        boton.target = viewController.revealViewController()
        boton.action = #selector(SWRevealViewController.revealToggle(_:))
        viewController.revealViewController().rightViewRevealWidth = 150
        viewController.view.addGestureRecognizer(viewController.revealViewController().panGestureRecognizer())
    }
}
