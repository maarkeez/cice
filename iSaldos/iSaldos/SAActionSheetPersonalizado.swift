//
//  SAActionSheetPersonalizado.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAActionSheetPersonalizado: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
