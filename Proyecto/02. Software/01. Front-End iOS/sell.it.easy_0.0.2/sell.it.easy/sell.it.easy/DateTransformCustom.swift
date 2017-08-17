//
//  DateFormatterCustom.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

open class DateTransformCustom: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeStr = value as? String {
            
            return timeStr.dateValue
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.stringValue
        }
        return nil
    }
}

