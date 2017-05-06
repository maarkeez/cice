//
//  LocalCoreDataService.swift
//  App_iMDb
//
//  Created by cice on 5/5/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import CoreData


class LocalCoreDataService {
    
    ///
    let remoteMovieService = RemoteItunesMovieService()
    
    ///
    let stack = CoreDataStack.shared
    
    ///Recupera las películas del servidor y llama a un callback con un array del modelo de datos
    func searchMovie(_ byTerm: String, remoteHandler: @escaping([MovieModel]?)->()){
        
        remoteMovieService.searchMovies(byTerm) { (result) in
            //Si traigo datos del servidor
            if let movieData = result{
                
                //Variable a devolver
                var modelMovie = [MovieModel]()
                
                //Para cada json del array en RESULT
                for movie in movieData{
                    
                    //Creo un objeto MovieModel
                    let obj = MovieModel(id: movie["id"]!, title: movie["movie"]!, order: nil, summary: movie["summary"]!, image: movie["image"]!, category: movie["category"]!, director: movie["director"]!)
                    
                    //Añado la película
                    modelMovie.append(obj)
                }
                
                remoteHandler(modelMovie)
                
            }else{
                print()
                remoteHandler(nil)
            }
        }
    }
    
    ///Devuelve 2 callbacks: Una con la información en local en CoreData y otro con la información de la llamada remota
    func topMovie(_ localHandler: @escaping([MovieModel]?)->(), remoteHandler: @escaping([MovieModel]?)->()){
        
        //Recuperamos los datos locales y llamamos al callback
        localHandler(queryTopMovies())
        
        //Recuperamos los datos del servidor, actualizamos datos locales y llamamos al callback
        remoteMovieService.getTopMovies { (result) in
            //Comprobar si contiene datos el array
            if let moviesDataJSON = result {
                
                //Marco todas las películas no favoritas como dessincronizadas
                self.markAllMoviesAnUnsync()
                
                //Variable para el orden
                var order = 1
                
                //Actualizamos o insertamos los valores en CoreData
                for movieJSON in moviesDataJSON {
                    
                    if let movie = self.getMovieByIdAndFavorito(movieJSON["id"]!, favorito: false){
                        //Si existe en local, UPDATE
                        self.updateMovie(movieJSON, movie: movie, order: order)
                        
                    }else{
                        //Si no existe en local, INSERT
                        self.insertMovie(movieJSON, order: order)
                    }
                    
                    order += 1
                }
                
                //Recupero las películas de CoreData
                remoteHandler(self.queryTopMovies())
                
            }else{
                print("topMovie: Error llamando a la API remota de iTunes para topMovie")
                remoteHandler(nil)
            }
            
            
        }
    }
    
    ///Recupera las topMovies de CoreData que no son favoritas
    func queryTopMovies() -> [MovieModel]? {
        
        //Recupero el contexto
        let ctx = stack.persistentContainer.viewContext
        
        //SELECT a CoreData
        let request : NSFetchRequest<MovieManager> = MovieManager.fetchRequest()
        
        //ORDER BY
        let sortDescription = NSSortDescriptor(key: "order", ascending: true)
        
        //WHERE
        let customPredicate = NSPredicate(format: "favorito = false") // \(false)
        
        //Añadir condiciones a la llamada
        request.sortDescriptors = [sortDescription]
        request.predicate = customPredicate
        
        //COREDATA execute
        do{
            //Consultar a CoreData
            let fecthMovies = try ctx.fetch(request)
            
            //Variable a devolver
            var movies = [MovieModel]()
            
            //Recorremos las películas del CoreData recuperadas
            for movie in fecthMovies{
                //Las añadimos al array
                movies.append(movie.mappedObj())
            }
            //Devolvemos el array con las películas.
            return movies
            
        }catch{
            
            print("queryTopMovies: Error en la consulta a CoreData")
            return nil
            
        }
    }
    
    ///Marca todas las películas como dessincronizadas en CoreData.
    ///Sólo para aquellas que no son favoritas
    func markAllMoviesAnUnsync(){
        
        
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManager> = MovieManager.fetchRequest()
        let customPredicate = NSPredicate(format: "favorito = false")
        request.predicate = customPredicate
        
        do {
            let movies = try ctx.fetch(request)
            
            for movie in movies {
                movie.sync = false
            }
            
            try ctx.save()
            
        } catch let error {
            print("markAllMoviesAnUnsync: Error actualizando todas las películas como dessincronizada en coredata. \(error.localizedDescription)")
        }
    }
    
    ///Recuperar de CoreData las películas filtrando
    func getMovieByIdAndFavorito(_ id: String, favorito: Bool) -> MovieManager?{
        
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<MovieManager> = MovieManager.fetchRequest()
        let customPredicate = NSPredicate(format: "id = '\(id)' and favorito = \(favorito)")
        
        request.predicate = customPredicate
        
        do{
            let movies = try ctx.fetch(request)
            
            if movies.count > 0 {
                return movies.first
            }
            return nil
            
        }catch let error{
            print("getMovieByIdAndFavorito: Error consultando CoreData \(error.localizedDescription)")
            return nil
        }
        
    }
    
    
    ///Actualizar una película "movie" a partir de un JSON "movieDiccionario" y le asigno un orden
    func updateMovie(_ movieDiccionario : [String:String], movie: MovieManager, order : Int){
        
        let context = stack.persistentContainer.viewContext
        movie.order = Int16(order)
        movie.title = movieDiccionario["title"]
        movie.summary = movieDiccionario["summary"]
        movie.director = movieDiccionario["director"]
        movie.image = movieDiccionario["image"]
        movie.category = movieDiccionario["category"]
        movie.sync = true
        
        do{
            try context.save()
        }catch let error {
            print("updateMovie: Error: \(error.localizedDescription)")
        }
        
    }
    
    ///Actualizar una película "movie" a partir de un JSON "movieDiccionario" y le asigno un orden
    func insertMovie(_ movieDiccionario : [String:String], order : Int){
        
        let context = stack.persistentContainer.viewContext
        let movie = MovieManager(context: context)
        movie.id = movieDiccionario["id"]
        updateMovie(movieDiccionario, movie: movie, order: order)
    }
}
