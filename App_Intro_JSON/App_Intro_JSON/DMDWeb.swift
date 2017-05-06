//
//  DMDWeb.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDWeb: UIViewController {

    
    //MARK : - IBOutlet
    @IBOutlet weak var myWebView: UIWebView!
    var internaURL : String?
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWeb()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func setWeb(){
        let myURL = URL(string: internaURL!)
        let requestObj = URLRequest( url: myURL!)
        self.myWebView.loadRequest(requestObj as URLRequest)
       
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
