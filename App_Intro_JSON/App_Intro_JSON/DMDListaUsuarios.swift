//
//  DMDListaUsuarios.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DMDListaUsuarios: UITableViewController {

    //MARK: - Variables locales
    var users : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        users = ManagerRepository.shared.getUsers()
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! DMDUserCell

        cell.setIBOutlets(user: users[indexPath.row])
        cell.myShowWebBTN.tag = indexPath.row
        cell.myShowWebBTN.addTarget(self, action: #selector(self.showWeb(_:)), for: .touchUpInside)
        
        cell.myShowMapBTN.tag = indexPath.row
        cell.myShowMapBTN.addTarget(self, action: #selector(self.showMap(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func showWeb(_ boton : UIButton){
        let webController = storyboard?.instantiateViewController(withIdentifier: "Web") as! DMDWeb
        
        webController.internaURL = "http://" + users[boton.tag].website!
        
        self.navigationController?.pushViewController(webController, animated: true)
    }
   
    func showMap(_ boton : UIButton){
        let webController = storyboard?.instantiateViewController(withIdentifier: "Map") as! DMDMap
        
        webController.initialLocation = CLLocation(latitude: (users[boton.tag].address?.geo?.lat!)!, longitude: (users[boton.tag].address?.geo?.lng!)!)
                       
        self.navigationController?.pushViewController(webController, animated: true)
    }
  

}
