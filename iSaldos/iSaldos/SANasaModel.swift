//
//  SANasaModel.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SANasaModel: NSObject {

    var Id : String?
    var fecha : String?
    var date : String?
    var explanation : String?
    var hdurl : String?
    var media_type : String?
    var service_version : String?
    var title : String?
    var url : String?
    
    
    init(Id : String?,
         fecha : String?,
         date : String?,
         explanation : String?,
         hdurl : String?,
         media_type : String?,
         service_version : String?,
         title : String?,
         url : String?){
        
        self.Id = Id
        self.fecha = fecha
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.media_type = media_type
        self.service_version = service_version
        self.title = title
        self.url = url
        super.init()
        
    }
    
}
