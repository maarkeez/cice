//
//  IMListFavorites.swift
//  App_iMDb
//
//  Created by cice on 5/5/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
//Para pintar de forma asíncrona la información
import Kingfisher


class IMListFavorites: UIViewController {

    //MARK: - Variables locales
    var movies = [MovieModel]()
    var collectionPadding : CGFloat = 0
    let dataProvider = LocalCoreDataService()
    var tapGR : UITapGestureRecognizer!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Añadir refresco automático
       
        //Personalizar collection view, añadiendo el refresco
        myCollectionView.refreshControl?.tintColor = UIColor.white
      

        automaticallyAdjustsScrollViewInsets = false
  
        setupPadding()
        
        
        myCollectionView.delegate  = self
        myCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dataProvider.updateFavoriteBadge(0)
    }
   
    

    func loadData(){
        
        if let moviesData = dataProvider.getFavoriteMovies(){
            movies = moviesData
            myCollectionView.reloadData()
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            //recuperar el indice de la movie seleccionada
            if let indexPathSelected = myCollectionView.indexPathsForSelectedItems?.last{
                //Recupero la película
                let selectedMovie = movies[indexPathSelected.row]
                
                
                //Crear vista detalle
                let detalleVC = segue.destination as! IMDetailMovie
                detalleVC.movie = selectedMovie
            }
        }
    }
    
}

// UICollectionViewDelegateFlowLayout para reajustar las celdas
extension IMListFavorites : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    ///Establecer separador entre las imagenes
    func setupPadding(){
        let anchoPantalla = self.view.frame.width
        let anchoCelda : CGFloat = 113
        let numeroCeldasPorFila : CGFloat = 3
        let totalSeparaciones : CGFloat = 4
        
        collectionPadding = (anchoPantalla - (numeroCeldasPorFila * anchoCelda)) / totalSeparaciones
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionPadding,
                            left: collectionPadding,
                            bottom: collectionPadding,
                            right: collectionPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionPadding
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///Si no hay datos retocamos mostrando una imagen con instrucciones
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(movies.count == 0){
            
            let imageView = UIImageView(image: #imageLiteral(resourceName: "sin-favoritas"))
            imageView.contentMode = .center
            
            myCollectionView.backgroundView = imageView

        }else{
            myCollectionView.backgroundView = UIView()
        }
        
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 113, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IMDetailCustomCell
        
        configureCell(cell, withMovie: movies[indexPath.row])
        
        return cell
    }
    
    func configureCell(_ cell : IMDetailCustomCell, withMovie movie: MovieModel){
        if let imageData = movie.image{
            
            cell.myImagen.kf.setImage(with: ImageResource(downloadURL: URL(string: imageData)!), placeholder: #imageLiteral(resourceName: "img-loading"), options: nil, progressBlock: nil, completionHandler: nil)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Recupero la película
        let selectedMovie = movies[indexPath.row]
        
        
        //Crear vista detalle
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detalleVC = storyboard.instantiateViewController(withIdentifier: "DetailMovie") as! IMDetailMovie
        detalleVC.movie = selectedMovie
        navigationController?.pushViewController(detalleVC, animated: true)
        
        
    }
    
}
