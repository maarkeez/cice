//
//  ViewController.swift
//  App_sinc_asinc
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables locales
    let urlString1 = "http://media.breitbart.com/media/2017/03/ap_barack-obama_ap-photo34-wi-e1446309401986-1-640x480.jpg"
    let urlString2 = "https://artescritorio.com/wp-content/uploads/2010/08/minimalwall-10-52-1-minimal-wallpaper-keep-it-simple-.png"
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenContendor: UIImageView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - IBActions
    ///Descarga síncrona
    @IBAction func syncDescarga(_ sender: Any) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
        let url = URL(string: urlString1)
        
        let data = NSData(contentsOf: url!)
        
        let image = UIImage(data: data! as Data)
        myImagenContendor.image = image
        
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
        
    }
    
    ///Descarga asíncrona con colas
    @IBAction func asyncDescarga(_ sender: Any) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
        
        
        //Creamos la cola de trabajo
        let queue = DispatchQueue(label: "downloadsSecondPriority",attributes : [])
        //Crear la url
        let url = URL(string: urlString2)
        
        
        //Llamamos a la cola de trabajo en segundo plano
        queue.async {
            do{
                let data =  try Data(contentsOf: url!)
                let image = UIImage(data: data)
                
                //Cola principal
                DispatchQueue.main.async {
                    self.myImagenContendor.image = image
                    self.myActivityIndicator.isHidden = true
                    self.myActivityIndicator.stopAnimating()
                }
                
            }catch{
                //Error recuperando la imagen
                self.myActivityIndicator.isHidden = true
                self.myActivityIndicator.stopAnimating()
            }
        }
    }
    
    ///Descarga asíncrona con callback
    @IBAction func asyncPlusDescarga(_ sender: Any) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
        
        
        setFotoFondo{ (imageData) in
            self.myActivityIndicator.isHidden = true
            self.myActivityIndicator.stopAnimating()
            self.myImagenContendor.image = imageData
        }
        
        
        //Callback que mostrará la imagen
        
        
        
        
        
    }
    
    //Valor de retorno del callback
    typealias imagenClosure = (_ image : UIImage) -> ()
    ///Función de callback para mostrar la imagen
    func setFotoFondo(_ callback : @escaping imagenClosure){
        //Crear cola con prioridad relativa en background
        DispatchQueue.global(qos: DispatchQoS.init(qosClass: .background, relativePriority: 1).qosClass).async {
            let url = URL(string: self.urlString2)
            
            do{
                let data = try Data(contentsOf: url!)
                let imagen = UIImage(data: data)
                
                DispatchQueue.main.async {
                    callback(imagen!)
                }
            }catch{
                
            }
        }
    }
    
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ocultar el activity indicator al incio.
        myActivityIndicator.isHidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

