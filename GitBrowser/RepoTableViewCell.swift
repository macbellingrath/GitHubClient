//
//  RepoTableViewCell.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {



    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var avatarimgview: CircularImageView!
    
    @IBOutlet weak var topTextLabel: UILabel!
    
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
