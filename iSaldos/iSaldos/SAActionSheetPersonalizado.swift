//
//  SAActionSheetPersonalizado.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAActionSheetPersonalizado: UIViewController {

    
    //MARK: - Variables locales
    var arrayRedesSociales = ["Facebook", "Twitter"]
    var arrayImagenesRedesSociales = ["like", "nation"]
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    
    //MARK: - IBActions
    @IBAction func cancelarACTION(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Limpiar el color de fondo para que sea transparente
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        
        //Editar estilo botón
        myCancelarBTN.layer.cornerRadius = 5
        
        //Editar estilo vista
        myCustomView.layer.cornerRadius = 5
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        //Delegados de la tabla
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

extension SAActionSheetPersonalizado : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRedesSociales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let texto = arrayRedesSociales[indexPath.row]
        let imagen = arrayImagenesRedesSociales[indexPath.row]
        
        celda.textLabel?.text = texto
        celda.detailTextLabel?.text = "\(Date())"
        celda.imageView?.image = UIImage(named: imagen)
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}
