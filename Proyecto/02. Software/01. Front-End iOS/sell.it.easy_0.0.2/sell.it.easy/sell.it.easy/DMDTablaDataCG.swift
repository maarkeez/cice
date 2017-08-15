//
//  DMDListadoCG.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDTablaDataCGDelegate{
    func deleteCelda(_ indice: Int)
    func updateCelda(_ indice: Int)
}

protocol DMDCeldaCGDelegate {
    func isSeleccionable() -> Bool
    func getAltura() -> CGFloat
    func getCelda(_ tabla: UITableView) -> UITableViewCell
    func getAcciones() -> [UITableViewRowAction]?
    func getTipo() -> Int
    func setIBOutlets(_ celda: UITableViewCell)
    
}

class DMDTablaDataCG {
    
    //MARK: - Variables locales
    var delegate : DMDTablaDataCGDelegate!

    var listaItems : [DMDCeldaCGDelegate] = []
    
    //Mostrar la barra de búsqueda por defecto
    var showSearchBar : Bool = false
    var guardar : Bool = false
    var isBackButton : Bool = false
    
    //MARK: - Utils
    
    func getItem(_ indice: Int) -> DMDCeldaCGDelegate {
        return listaItems[indice]
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return listaItems.count
    }
    
    func getHeightForRowAt(_ indice: Int) -> CGFloat{
        return getItem(indice).getAltura()
    }
    
    func getCelda(_ indice: Int, tabla: UITableView) -> UITableViewCell{
        return getItem(indice).getCelda(tabla)
    }
    
    func getAcciones(_ indice: Int) ->[UITableViewRowAction]?{
        return getItem(indice).getAcciones()
    }
    
    func deleteCelda(_ indice: Int){
        delegate.deleteCelda(indice)
    }
    
    func updateCelda(_ indice: Int){
        delegate.updateCelda(indice)
    }
}
