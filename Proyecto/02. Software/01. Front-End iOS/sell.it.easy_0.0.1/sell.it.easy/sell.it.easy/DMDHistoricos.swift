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

    
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cabecera paginada
        let items = [#imageLiteral(resourceName: "sell")  , #imageLiteral(resourceName: "orders") , #imageLiteral(resourceName: "inventory"),#imageLiteral(resourceName: "uniform"), #imageLiteral(resourceName: "broken")]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.setNormalColor(CONSTANTES.COLOR.AZUL_CLARO)
        carbonTabSwipeNavigation.setIndicatorColor(CONSTANTES.COLOR.AZUL_OSCURO)
        carbonTabSwipeNavigation.setSelectedColor(CONSTANTES.COLOR.AZUL_OSCURO)
        carbonTabSwipeNavigation.toolbar.backgroundColor =  CONSTANTES.COLOR.GRIS
        carbonTabSwipeNavigation.toolbar.alpha = 1.0
        
        //Permitir mostrar menú con el botón
        mostrarMenu(myMenuBTN)
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "DMDHistoricoRecepciones") as! DMDHistoricoRecepciones
    }

}
