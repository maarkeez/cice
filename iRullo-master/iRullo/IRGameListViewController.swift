//
//  IRGameListViewController.swift
//  iRullo
//
//  Created by formador on 7/4/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import CoreData



class IRGameListViewController: UIViewController {

    //MARK: -  Variables locales
    //Contexto del CoreData
    var manageContext : NSManagedObjectContext?
    var listGames = [Game]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myFilterSegmentControl: UISegmentedControl!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    //MARK: - IBActions
    @IBAction func filterChangeACTION(_ sender: Any) {
        performGamesQuery()
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //Collection view
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        //Siempre arrastro de arriba a abajo
        myCollectionView.alwaysBounceVertical = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Recuperamos la información y la repintamos.
        performGamesQuery()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGameSegue" {
            let navVC = segue.destination as! UINavigationController
            let detalleVC = navVC.topViewController as! IRAddGameViewController
            
            //Pasamos el contexto entre controladores
            detalleVC.manageContext = manageContext
            
            detalleVC.irDelegate = self
        }
        
        if segue.identifier == "editGameSegue" {
            let detalleVC = segue.destination as! IRAddGameViewController
            //Pasamos el contexto entre controladores
            detalleVC.manageContext = manageContext
            
            let selectedIndex = myCollectionView.indexPathsForSelectedItems?.first?.row
            let gameSelected = listGames[selectedIndex!]
            
            detalleVC.game = gameSelected
            
            detalleVC.irDelegate = self

        }
    }
    
    //MARK: - Utils
    ///Permite pintar un string de un color hasta la aparición de ":"
    func formatColors(_ myString: String, myColor: UIColor) -> NSMutableAttributedString {
        
        //Tamaño del string
        let length = myString.characters.count
        
        //Posición para los dos puntos
        let colonPosition = myString.indexOf(":")!
        
        //String con atributos
        let myMutableString = NSMutableAttributedString(string: myString)
        
        //Añadir atributos
        let myRango = NSRange(location: 0, length: length)
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: myColor, range: myRango)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location: 0, length: colonPosition + 1))
        
        return myMutableString
        
    }
    
    ///Consulta de CoreData
    func performGamesQuery(){
        //SELECT
        let customRequest : NSFetchRequest<Game> = Game.fetchRequest()
        
        //ORDER BY
        let sortByDate = NSSortDescriptor(key: "dateCreated", ascending: false)
        customRequest.sortDescriptors = [sortByDate]
        
        //WHERE
        if myFilterSegmentControl.selectedSegmentIndex == 0{
            let customPredicate = NSPredicate(format: "borrowed = true")
            customRequest.predicate = customPredicate
        }
        
        //EXECUTE
        do{
            let fetchedGames = try manageContext?.fetch(customRequest)
            
            if let listaJuegos = fetchedGames{
                listGames = listaJuegos
                self.myCollectionView.reloadData()
            }
        }catch let error{
            print("ERROR: recuperando listado de juegos.  \(error). ")
        }
    }
    
    
}

//MARK: - Extensión para gestionar CollectionView
extension IRGameListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if listGames.count == 0{
            //Si no tengo datos, muestro una imagen de fondo
            let imageBackground = UIImageView(image: #imageLiteral(resourceName: "img_empty_list"))
            imageBackground.contentMode = .scaleAspectFit
            myCollectionView.backgroundView = imageBackground
        }else{
            
            //Si tengo datos, borro la imagen de fondo
            myCollectionView.backgroundView = UIView()

        }
        return listGames.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCustomCell", for: indexPath) as! IRDetailCustomCell
        
        
        
        //Pintar la celda
        let game = listGames[indexPath.row]
        
        //Titulo
        customCell.myNameGame.text = game.title
        
        //Prestado
        var myColorPrestado = CONSTANTES.COLORES.ROJO
        var prestado = "SI"
        if !game.borrowed {
            myColorPrestado = CONSTANTES.COLORES.AZUL
            prestado = "NO"
        }
        customCell.myBorrowedLBL.attributedText = formatColors("PRESTADO: \(prestado)", myColor: myColorPrestado)
        
        //Quien
        if let borrowedTo = game.borrowedTo{
            customCell.myBorrowedToLBL.attributedText = formatColors("A: \(borrowedTo)", myColor: myColorPrestado)
        }else{
            customCell.myBorrowedToLBL.attributedText = formatColors("A: --", myColor: myColorPrestado)
        }
        
        //Fecha prestamo
        if let borrowedDate = game.borrowedDate as Date?{
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "dd/MM/yyyy"
            let myFechaFormateada = myDateFormatter.string(from: borrowedDate)
            
            customCell.myBorrowedDateLBL.attributedText = formatColors("FECHA: \(myFechaFormateada)", myColor: myColorPrestado)
        }else{
            customCell.myBorrowedDateLBL.attributedText = formatColors("FECHA: --", myColor: myColorPrestado)
        }
        
        //Imagen
        if let imagenData = game.image as Data? {
            customCell.myImageGame.image = UIImage(data: imagenData)
        }
        
        //Añadir sombreado a la celda
        customCell.layer.masksToBounds = false
        customCell.layer.shadowOffset = CGSize(width: 1, height: 1  )
        customCell.layer.shadowColor = CONSTANTES.COLORES.GRIS_BARRA_NAVEGACION.cgColor
        customCell.layer.shadowRadius = 2.0
        customCell.layer.shadowOpacity = 0.2
        
        return customCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editGameSegue", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Distancia arrastrada desde arriba
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < -120 {
            performSegue(withIdentifier: "addGameSegue", sender: self)
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout (Ajustar la celda a cualquier dispositivo)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width - 16, height: 400.0)
    }
}

//MARK: - Extensión para actualizar a partir del controlador de Añadir/Editar
///Esto se puede quitar, no aporta nada
extension IRGameListViewController : IRAddGameViewControllerDelegate {
    func didAddGame() {
        myCollectionView.reloadData()
    }
}

//MARK: - Extensión para añadir texto enriquecido
extension String {
    
    ///Recupera el indice para la primera aparición de un string y en caso contrario devuelve nil
    func indexOf(_ myString : String) -> Int? {
        if let myRange = self.range(of: myString){
            return distance(from: self.startIndex, to: myRange.lowerBound)
        }
        return nil
    }
}
