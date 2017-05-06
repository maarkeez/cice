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
    
    func hideKeyBoard(){
        
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
    
    
    
}
