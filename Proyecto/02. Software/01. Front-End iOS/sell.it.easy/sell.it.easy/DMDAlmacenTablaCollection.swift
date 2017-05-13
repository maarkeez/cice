//
//  DMDAlmacenTablaCollection.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAlmacenTablaCollection: UITableViewController {

    //MARK: - Variables locales
    var tienda : Tienda = Tienda()
    
    //Array con las posiciones del scroll por cada collection view
    var storedOffsets = [Int : [Int: CGFloat]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "AlmacenTablaCelda", for: indexPath)
        
        return celda
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 364
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sección"
    }
    ///Es necesario llamar a esta función para poder establecer el delegado y el número de celda dentro del collection view cell
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Recuperamos la celda
        guard let celda = cell as? DMDAlmacenTablaCelda else { return }
        //Establecemos el delegado y el número de celda
        celda.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        celda.collectionViewOffset = storedOffsets[indexPath.section]?[indexPath.row] ?? 0
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let celda = cell as? DMDAlmacenTablaCelda else { return }
        if storedOffsets[indexPath.section] == nil{
        
            storedOffsets[indexPath.section] = [Int: CGFloat]()
            
        }
        storedOffsets[indexPath.section]![indexPath.row] = celda.collectionViewOffset
        
        
        
    }
}

//MARK: - Delegado collection view
extension DMDAlmacenTablaCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return REST_productos.productos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Esta celda debe ser registrada previamente en el contenedor
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlmacenCeldaCollection",
                                                      for: indexPath ) as! DMDAlmacenCeldaCollection
        
        cell.setIBOutlets(producto: REST_productos.productos[indexPath.item])
        
        return cell
    }
}
