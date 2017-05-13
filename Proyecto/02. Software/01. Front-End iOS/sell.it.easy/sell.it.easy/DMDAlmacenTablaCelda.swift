//
//  AlmacenTablaCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAlmacenTablaCelda: UITableViewCell {
    
    //MARK: - Variables locales
    ///Almacenamos el scroll realizado sobre la collection
    var collectionViewOffset: CGFloat {
        get {
            return myCollectionView.contentOffset.x
        }
        
        set {
            myCollectionView.contentOffset.x = newValue
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet private weak var myCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myCollectionView.register(UINib(nibName: "DMDAlmacenCeldaCollection", bundle: nil), forCellWithReuseIdentifier: "AlmacenCeldaCollection")
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Utils
    ///Función para crear el delegado, la fuente de datos y 
    ///el número de fila en la CollectionView que contiene los productos
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        myCollectionView.delegate = dataSourceDelegate
        myCollectionView.dataSource = dataSourceDelegate
        myCollectionView.tag = row
        myCollectionView.reloadData()
    }

    
}
