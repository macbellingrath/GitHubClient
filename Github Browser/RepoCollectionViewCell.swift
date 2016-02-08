//
//  RepoCollectionViewCell.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/7/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell, ViewConfigurable {
    

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var eventTypeLabel: UILabel!
    
    @IBOutlet weak var avatarImgView: CircularImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionTextView: UITextView!
    
    
    override func drawRect(rect: CGRect) {
        let contView = UIView(frame: rect)
        contView.backgroundColor = UIColor(red:0, green:0.49, blue:1, alpha:1)
        contView.layer.cornerRadius = 50
        contView.layer.masksToBounds = true
        contView.layer.masksToBounds = false
        contView.layer.shadowOffset = CGSizeMake(-1, 1)
        contView.layer.shadowOpacity = 0.2
        
        backgroundView = contView
        
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor.cyanColor()
        bgView.layer.cornerRadius = 50
        bgView.layer.masksToBounds = true
        bgView.layer.masksToBounds = false
        bgView.layer.shadowOffset = CGSizeMake(-1, 1)
        bgView.layer.shadowOpacity = 0.2


        self.selectedBackgroundView = bgView
        
    }

}
