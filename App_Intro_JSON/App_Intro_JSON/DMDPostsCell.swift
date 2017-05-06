//
//  DMDPostsCell.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPostsCell: UITableViewCell {

    
    //MARK: - IBOutlets
    @IBOutlet weak var myId: UILabel!
    @IBOutlet weak var myUserId: UILabel!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myBody: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIBOutlets(post : Posts){
        myId.text = "\(post.id!)"
        myUserId.text = "\(post.userId!)"
        myTitle.text = "\(post.title!)"
        myBody.text = "\(post.body!)"
    }

}
