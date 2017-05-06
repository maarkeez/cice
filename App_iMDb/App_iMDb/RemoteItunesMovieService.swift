//
//  RemoteItunesMovieService.swift
//  App_iMDb
//
//  Created by cice on 28/4/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RemoteItunesMovieService {
    
    ///Recupera las primeras 99 películas de iTunnes
    /// - parameters: completionHandler callback que devuelve un diccionario de Strings
    func getTopMovies(_ completionHandler : @escaping([[String:String]]?)  -> ()) {
        
        //Url del método para top de iTunes
        let urlData = CONSTANTES.URL.ITUNES + CONSTANTES.METODO.TOP
        
        //Realizar llamada GET con POD Alamofire
        Alamofire.request(URL(string: urlData)!, method: .get).validate().responseJSON {
            (responseData) in
            
            switch responseData.result{
                
            case .success:
                //Si la respuesta es OK
                if let valorData = responseData.result.value{
                    //Recuperar los valores como JSON
                    let json = JSON(valorData)
                    
                    //Crear Array de diccionarios para devolver
                    var resultData = [[String:String]]()
                    
                    //Recuperar las entradas del JSON
                    let entries = json["feed"]["entry"].arrayValue
                    
                    //Recuperamos las entradas
                    for entry in entries {
                        //Diccionario para la entrada
                        var movieDiccionario = [String : String]()
                        
                        //ID
                        movieDiccionario["id"] = entry["id"]["attributes"]["im:id"].stringValue
                        
                        //TITULO
                        movieDiccionario["title"] = entry["im:name"]["label"].stringValue
                        
                        //RESUMEN
                        movieDiccionario["summary"] = entry["summary"]["label"].stringValue
                        
                        //IMAGEN aumentamos la resolución
                        movieDiccionario["image"] = entry["im:image"][0]["label"].stringValue.replacingOccurrences(of: "60x60", with: "500x500")
                        
                        //CATEGORIA
                        movieDiccionario["category"] = entry["category"]["attributes"]["label"].stringValue
                        
                        //DIRECTOR
                        movieDiccionario["director"] = entry["im:artist"]["label"].stringValue
                        
                        
                        
                        
                        //Añadimos al array el objeto
                        resultData.append(movieDiccionario)
                    }
                    
                    completionHandler(resultData)
                }
            case .failure(let error):
                //Si la respuesta es KO
                print("Error llamada getTopMovies: \(error.localizedDescription)")
                completionHandler(nil)
                
            }
        }
        
    }
    
    
    
    
    ///Permite buscar películas a partir de un término
    func searchMovies(_ byTerm: String, completionHandler: @escaping([[String:String]]?)->()){
        
        //Base URL del método
        let urlData = URL(string: CONSTANTES.URL.ITUNES + CONSTANTES.METODO.SEARCH)
        
        //Llamada GET con parámetros
        Alamofire.request(urlData!,
                          method: .get,
                          parameters: ["media":"movie", "attribute":"movieTerm", "term":byTerm],
                          encoding: URLEncoding.default,
                          headers: nil).validate().responseJSON { (responseData) in
                            
                            //Tratamos la respuesta
                            switch responseData.result{
                            case .success:
                                //Si la respuesta es OK
                                if let valorData = responseData.result.value{
                                    //Recuperar los valores como JSON
                                    let json = JSON(valorData)
                                    
                                    //Crear Array de diccionarios para devolver
                                    var resultData = [[String:String]]()
                                    
                                    //Recuperar las entradas del JSON
                                    let entries = json["results"].arrayValue
                                    
                                    //Recuperamos las entradas
                                    for entry in entries {
                                        //Diccionario para la entrada
                                        var movieDiccionario = [String : String]()
                                        
                                        //ID
                                        movieDiccionario["id"] = entry["trackId"].stringValue
                                        
                                        //TITULO
                                        movieDiccionario["title"] = entry["trackName"].stringValue
                                        
                                        //RESUMEN
                                        movieDiccionario["summary"] = entry["longDescription"].stringValue
                                        
                                        //IMAGEN aumentamos la resolución
                                        movieDiccionario["image"] = entry["artworkUrl100"].stringValue.replacingOccurrences(of: "100x100", with: "500x500")
                                        
                                        //CATEGORIA
                                        movieDiccionario["category"] = entry["primaryGenreName"].stringValue
                                        
                                        //DIRECTOR
                                        movieDiccionario["director"] = entry["artistName"].stringValue
                                        
                                        
                                        
                                        
                                        //Añadimos al array el objeto
                                        resultData.append(movieDiccionario)
                                    }
                                    
                                    completionHandler(resultData)
                                    
                                    
                                }
                            case .failure(let error):
                                print("Error searchMovies \(error.localizedDescription)")
                                completionHandler(nil)
                            }
        }
    }
}



