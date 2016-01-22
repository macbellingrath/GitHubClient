//
//  RepoTableViewCell.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarimgview: CircularImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        @IBOutlet weak var avatarimgview: CircularImageView!
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
