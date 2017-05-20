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
        
        //Color para los titulos NO seleccionados
        carbonTabSwipeNavigation.setNormalColor(CONSTANTES.COLOR.AZUL_CLARO)
        //Color para la barra inferior
        carbonTabSwipeNavigation.setIndicatorColor(CONSTANTES.COLOR.AZUL_OSCURO)
        //Color para el título SI seleccionado
        carbonTabSwipeNavigation.setSelectedColor(CONSTANTES.COLOR.AZUL_OSCURO)
        //Color de fondo del menú
        carbonTabSwipeNavigation.toolbar.backgroundColor =  CONSTANTES.COLOR.GRIS
        //Transparencia del menu
        carbonTabSwipeNavigation.toolbar.alpha = 1.0
        //Añadir ancho extra a los titulos
        carbonTabSwipeNavigation.setTabExtraWidth(CGFloat(30))
       
        
        //Permitir mostrar menú con el botón
        mostrarMenu(myMenuBTN,delegado:  self)
    }

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "DMDHistoricoRecepciones") as! DMDHistoricoRecepciones
    }

}
