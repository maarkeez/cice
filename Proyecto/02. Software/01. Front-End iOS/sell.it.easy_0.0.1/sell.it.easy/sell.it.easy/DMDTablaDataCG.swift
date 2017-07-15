//
//  DMDListadoCG.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDTablaDataCGDelegate{
    func getCelda(_ indice: Int) -> DMDCeldaCGDelegate
    func deleteCelda(_ indice: Int)
    func updateCelda(_ indice: Int)
}

class DMDTablaDataCG {
    
    //MARK: - Variables locales
    var delegate : DMDTablaDataCGDelegate!

    var listaItems : [DMDCeldaCGDelegate] = []
    
    //MARK: - Utils
    
    func getItem(_ indice: Int) -> DMDCeldaCGDelegate {
        return delegate.getCelda(indice)
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
    
    func getCelda(_ indice: Int) -> UITableViewCell{
        return getItem(indice).getCelda()
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


protocol DMDCeldaCGDelegate {
    func getAltura() -> CGFloat
    func getCelda() -> UITableViewCell
    func getAcciones() -> [UITableViewRowAction]?
    
}
