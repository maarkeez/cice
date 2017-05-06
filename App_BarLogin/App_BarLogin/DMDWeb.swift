//
//  DMDWeb.swift
//  App_BarLogin
//
//  Created by cice on 3/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDWeb: UIViewController {
    
    //MARK: - Variables locales
    var URLString : String?
    let batDelegate = UIApplication.shared.delegate as! AppDelegate //Creo la instancia del AppDelegate, para poder girar la pantalla
    
    //MARK: - IBOutlets
    @IBOutlet weak var myWebView: UIWebView!
    
    //MARK: - Actions
    @IBAction func cerrarViewController(_ sender: AnyObject) {
        batDelegate.puedoRotar = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func irAtras(_ sender: AnyObject) {
        myWebView.goBack()
    }
    @IBAction func irAdelante(_ sender: AnyObject) {
        myWebView.goForward()
    }
    
    @IBAction func recargarPagina(_ sender: AnyObject) {
        myWebView.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        batDelegate.puedoRotar = true
        
        let customURL = URL(string: URLString!)
        let request = URLRequest(url: customURL!)
        myWebView.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Orientamos la pantalla en horizontal
        
    }
    
    //MARK: - Variables para la orientacion
    //Indica si debería rotarme
    override var shouldAutorotate: Bool{
        return true
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
