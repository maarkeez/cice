//
//  SAGaleriaImagenesViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAGaleriaImagenesViewController: UIViewController {

    //MARK: - Variables locales
    
    //MARK: - IBOutlets
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myPageControllerGaleria: UIPageControl!
    
    
    
    
    
    //MARK: - IBActions
    @IBAction func showLoginACTION(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "SALoginViewController") as! SALoginViewController
        
        present(loginVC, animated: true, completion: nil)
    }
    
    
    
    ///Muestra una serie de imágenes con el tutorial de la aplicación
    ///Tras el segundo acceso no se mostrará
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ancho de la imagen
        let anchoImagen = view.frame.size.width
        let altoImagen = view.frame.height
        
        
        //Generar las imágenes
        for i in 0..<8 {
            
            // Contendor con la imagen
            let imagen = UIImageView(image: UIImage(named: String(format: "FOTO_%d.jpg", i)))
            
            //Ajustar las medidas
            //Es del tamaño de la pantalla
            //La X es lo que nos permite ocultarlas, porque quedarían fuera de la pantalla.
            imagen.frame = CGRect(x: CGFloat(i) * anchoImagen,
                                    y: 0,
                                    width: anchoImagen,
                                    height: altoImagen)
            
            //Añadimos la imagen
            myScrollView.addSubview(imagen)
            
        }
        //Asignar delegado
        myScrollView.delegate = self
        
        //Asignar tamaño del contendor para el scroll
        myScrollView.contentSize = CGSize(width: 7  * anchoImagen, height: altoImagen)
        
        
        //Habilitar la paginación
        myScrollView.isPagingEnabled = true
        
        //Asignar el número de páginas
        myPageControllerGaleria.numberOfPages = 7
        
        //Asignar página actual
        myPageControllerGaleria.currentPage = 0
        

    }

}



//MARK: - Extensión para hacer scroll
extension SAGaleriaImagenesViewController : UIScrollViewDelegate {

    //Cuando terminas de mover el scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //Calculo a partir de los tamaños de la imagen y de la posición actual
        //La página en la que estoy
        let page = self.myScrollView.contentOffset.x / self.myScrollView.frame.width
        
        //Asigno la página al paginador
        myPageControllerGaleria.currentPage = Int(page)
        
    }
}




































