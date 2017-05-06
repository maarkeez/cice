//
//  utils.swift
//  solosView
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

//MARK: - Tipos
typealias jsonStandar = [String : Any]


//MARK: - Funciones 

func transformarFecha (fecha : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "es_ES")
    return dateFormatter.string(from: fecha)
}

