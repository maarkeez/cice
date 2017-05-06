//
//  ManagerRepository.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

class ManagerRepository {
    //MARK: - Variables locales
    var postsParser = PostsParser()
    var userParser = UsersParser()
    
    //MARK: - Singleton
    static let shared = ManagerRepository()
    
    //MARK: - Funciones
    ///Obtener todos los posts
    /// - Returns: Listado de posts a partir del repositorio del WS.
    func getPosts() -> [Posts] {
        let url = URL(string: CONSTANTES.BASE_URL.POSTS)
        
        let postsData = NSData(contentsOf: url!)
        
       return postsParser.getPostsParser(dataFromNetwork: postsData!)
        
    }
    
    func getUsers() -> [User]{
        let url = URL(string: CONSTANTES.BASE_URL.USERS)
        
        let usersData = NSData(contentsOf: url!)
        
        return userParser.getUsersParser(dataFromNetwork: usersData!)
    }
    
    
}
