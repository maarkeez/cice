//
//  IMDetailMovie.swift
//  App_iMDb
//
//  Created by cice on 5/5/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
import Kingfisher

class IMDetailMovie: UIViewController {

    //MARK: - Variables locales
    var movie : MovieModel?
    let dataProvider = LocalCoreDataService()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myTitulo: UILabel!
    @IBOutlet weak var myDirector: UILabel!
    @IBOutlet weak var myCategoria: UILabel!
    @IBOutlet weak var myDescripción: UITextView!
    @IBOutlet weak var myAddFavoritosBTN: UIButton!
    
    //MARK: - IBActions
    
    ///Cambia el estado de favorito para la película
    ///Repinta el fondo y el título del botón
    @IBAction func myAddFavoritosACTION(_ sender: Any) {
        
        if let movieData = movie{
            dataProvider.markUnMarkFavorite(movieData)
            configuracionBTN()
        }
        dataProvider.updateFavoriteBadge()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movieData = movie{
            
            myTitulo.text = movieData.title
            self.title = movieData.title
            myDirector.text = movieData.director
            myCategoria.text = movieData.category
            myDescripción.text = movieData.summary
            
            if let imageData = movieData.image{
                myImagen.kf.setImage(with: ImageResource(downloadURL: URL(string: imageData)!))
            }
        }
        
        configuracionBTN()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///Permite cambiar el estilo del botón en función de si la película está marcada como favorita localmente, o no.
    func configuracionBTN(){
        if let movieData = movie {
            if dataProvider.isMovieFavourite(movieData){
                myAddFavoritosBTN.setBackgroundImage(#imageLiteral(resourceName: "btn-on"), for: .normal)
                myAddFavoritosBTN.setTitle("Te gusta!", for: .normal)
            }else{
                myAddFavoritosBTN.setBackgroundImage(#imageLiteral(resourceName: "btn-off"), for: .normal)
                myAddFavoritosBTN.setTitle("No te gusta :(", for: .normal)
            }
        }
    }

}










