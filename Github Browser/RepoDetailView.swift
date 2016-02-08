//
//  RepoDetailView.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/8/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

@IBDesignable
class RepoDetailView: UIView {
    
    var repodetail: RepoDetail?
    
    @IBOutlet weak var repoTitleLabel: UILabel!
    
    @IBOutlet weak var repoLanguageLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    
    @IBOutlet weak var repoWatchersLabel: UILabel!
    
    @IBOutlet weak var repoCreatedLabel: UILabel!
    @IBOutlet weak var repoUpdatedLabel: UILabel!
    
    @IBOutlet weak var repoForksCountLabel: UILabel!
    
    @IBOutlet weak var repoIssuesCountLabel: UILabel!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
