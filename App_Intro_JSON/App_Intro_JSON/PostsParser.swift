//
//  PostsParser.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import SwiftyJSON


class PostsParser{
    
    ///Permite parsear la información proporcionada como NSData para devolver un listado de Posts
    /// - Parameter dataFromNetwork: Data con el contenido a convertir en un listado de objetos Post
    /// - Returns: Listado de Posts contenido en dataFromNetwork
    func getPostsParser(dataFromNetwork : NSData) -> [Posts]{
        var posts : [Posts] = []
        let legibleJSON = JSON(data: dataFromNetwork as Data)
        //let legibleJSON = JSON(data: dataFromNetwork as Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        print(legibleJSON)
        for i in 0..<legibleJSON.count{
            let post = Posts(userId: legibleJSON[i]["userId"].int, id: legibleJSON[i]["id"].int, title: legibleJSON[i]["title"].string, body: legibleJSON[i]["body"].string)
            posts.append(post)
        }
        return posts
    }
    
}
