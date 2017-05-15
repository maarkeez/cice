//
//  DMDHistoricos.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import CarbonKit


class DMDHistoricos: UIViewController, CarbonTabSwipeNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = ["Ventas", "Recepciones", "Inventarios","Cesiones gratuitas", "Taras"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        // Do any additional setup after loading the view.
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "DMDHistoricoRecepciones") as! DMDHistoricoRecepciones
    }

}
