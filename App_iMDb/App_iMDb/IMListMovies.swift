//
//  IMListMovies.swift
//  App_iMDb
//
//  Created by cice on 5/5/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
//Para pintar de forma asíncrona la información
import Kingfisher

class IMListMovies: UIViewController {
    
    //MARK: - Variables locales
    var movies = [MovieModel]()
    var collectionPadding : CGFloat = 0
    let customRefresh = UIRefreshControl()
    let dataProvider = LocalCoreDataService()
    var tapGR : UITapGestureRecognizer!
    
    //MARK: - IBOutlets
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Añadir refresco automático
        customRefresh.addTarget(self, action: #selector(loadData), for: .valueChanged  )
        
        //Personalizar collection view, añadiendo el refresco
        myCollectionView.refreshControl?.tintColor = UIColor.white
        myCollectionView.refreshControl = customRefresh
        
        
        tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        
        loadData()
        
        setupPadding()
        
        
        myCollectionView.delegate  = self
        myCollectionView.dataSource = self
        mySearchBar.delegate = self
    }
    
    func loadData(){
        dataProvider.topMovie({ (localResult) in
            //RECARGAR DATOS
            if let moviesDes = localResult{
                self.movies = moviesDes
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
            //self.customRefresh.endRefreshing()
        }) { (remoteResult) in
            //RECARGAR DATOS
            if let moviesDes = remoteResult{
                self.movies = moviesDes
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                    self.customRefresh.endRefreshing()
                }
            }
        }
    }
    
    //Oculta el teclado y remueve el gesto de reconocimiento
    func hideKeyBoard(){
        mySearchBar.resignFirstResponder()
        self.view.removeGestureRecognizer(tapGR)
        
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
extension IMListMovies : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    // ---------------------------------
    // SEARCHBAR DELEGATE
    // ---------------------------------
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.addGestureRecognizer(tapGR)
    }
    
    //Si el texto es vacío buscamos todas las películas
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            loadData()
        }
    }
    
    //Si pulsamos buscar el texto buscado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Recuperamos el término de búsqueda
        if let term = searchBar.text{
            
            //Realizamos la búsqueda
            dataProvider.searchMovie(term, remoteHandler: { (resultMovie) in
                if let movies = resultMovie {
                    self.movies = movies
                    DispatchQueue.main.async {
                        //Repintamos y ocultamos el teclado
                        self.myCollectionView.reloadData()
                        searchBar.resignFirstResponder()
                    }
                }else{
                    
                }
            })
        }
    }
}























































