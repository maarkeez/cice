//
//  Placeholder.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

/*
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "http://placehold.it/600/92c952",
 "thumbnailUrl": "http://placehold.it/150/92c952"
 }
 */

@objc(Placeholder)
class Placeholder : NSObject {
    var albumId : Int = 0
    var id : Int = 0
    var title : String = ""
    var url : String = ""
    var thumbnailUrl : String = ""
    
    
    override init(){
        super.init()
    }
    
    init(albumId : Int, id: Int, title: String, url: String, thumbnailUrl: String){
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        
    }
}
