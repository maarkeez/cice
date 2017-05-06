//
//  DMDSegundoVC.swift
//  APP_GCD_OperationQueue
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

//Operation Queue
class DMDSegundoVC: UIViewController {
    
    //MARK: - Variables locales
    
    //Cola de operaciones
    var myOperationsQueue : OperationQueue?
    
    //URL con imágenes de 20Mb
    let URLimagen1 = "http://s1.1zoom.me/big3/652/Lykan_Hypersport_W_448900.jpg"
    let URLimagen2 = "https://images8.alphacoders.com/393/393070.jpg"
    let URLimagen3 = "https://images7.alphacoders.com/739/739692.jpg"
    let URLimagen4 = "https://images7.alphacoders.com/711/711452.jpg"
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagen1: UIImageView!
    @IBOutlet weak var myImagen2: UIImageView!
    @IBOutlet weak var myImagen3: UIImageView!
    @IBOutlet weak var myImagen4: UIImageView!
    
    //MARK: - IBActions
    @IBAction func cancellAllOperationsACTION(_ sender: Any) {
        myOperationsQueue?.cancelAllOperations()
        
    }
    
    
    //MARK: - LIFE VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        downloadImages()
    }
    
    
    //MARK: - Utils
    func downloadImages(){
        //Bloque de operaciones
        let operation1 = createBloque(myImagen: myImagen1, URLimagen: URLimagen1)
        let operation2 = createBloque(myImagen: myImagen2, URLimagen: URLimagen2)
        let operation3 = createBloque(myImagen: myImagen3, URLimagen: URLimagen3)
        let operation4 = createBloque(myImagen: myImagen4, URLimagen: URLimagen4)
        
        
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)
        
        
        myOperationsQueue = OperationQueue()
        myOperationsQueue?.addOperation(operation1)
        myOperationsQueue?.addOperation(operation2)
        myOperationsQueue?.addOperation(operation3)
        myOperationsQueue?.addOperation(operation4)
        
    }
    
    ///Crea un bloque encargado de recuperar una imagen de una URL y asignarlo a la imagen de un UIImageView
    func createBloque(myImagen : UIImageView, URLimagen : String) -> BlockOperation{
        return BlockOperation{
            do{
                let imagen = UIImage(data: try Data(contentsOf: URL(string: URLimagen)!))
                
                OperationQueue.main.addOperation {
                    myImagen.image = imagen
                }
            }catch{
                print("Error")
            }
        }
    }
    
}
