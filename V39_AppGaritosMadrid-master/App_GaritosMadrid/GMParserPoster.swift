//
//  GMParserPoster.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
import CoreData //DMD Para mi parser

class GMParserPoster : NSObject {
    
    
    var jsonDataPosterImdb : JSON?
    
    func getDataImdb(_ id: String, page: String) -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.BASE_URL.OMDB + id + "&page=" +  page)!)
        
        return Alamofire.request(customRequest).responseJSON().then{ (data) -> JSON in
            self.jsonDataPosterImdb = JSON(data)
            return self.jsonDataPosterImdb!
        }
    }
    
    func getParseImdb() -> [Poster]{
        var listaPoster = [Poster]()
        
        for item in jsonDataPosterImdb!["Search"]{
            var poster = Poster()
            poster = Parseador.shared.parse(with: Mirror(reflecting: poster), from: item.1 , to: poster) as! Poster
            listaPoster.append(poster)
        }
        return listaPoster
    }
    
    
    
}
