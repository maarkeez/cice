//
//  StringExts.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var dateValue : Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.date(from: self)!
    }
    
}
