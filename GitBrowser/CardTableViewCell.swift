//
//  CardTableViewCell.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/27/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var contView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var eventTypeTextLabel: UILabel!
    

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
    
    override func drawRect(rect: CGRect) {
        contentView.backgroundColor = UIColor.clearColor()
        contView.backgroundColor = UIColor.whiteColor()
        contView.layer.cornerRadius = 10
        contView.layer.masksToBounds = true
        contView.layer.masksToBounds = false
        contView.layer.shadowOffset = CGSizeMake(-1, 1)
        contView.layer.shadowOpacity = 0.2
        
        self.contentView.addSubview(contView)
    }

}

