//
//  DetailViewController.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/28/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

protocol ViewConfigurable {
    func configureView(forActivity activity: Activity)
    weak var avatarImgView: CircularImageView! { get set }
    weak var userNameLabel: UILabel! { get set }
    weak var repoNameLabel: UILabel! { get set }
    weak var eventTypeLabel: UILabel! { get set }
    weak var dateLabel: UILabel! { get set }
    
    
}
extension ViewConfigurable {
    
    func configureView(forActivity activity: Activity) {
    NetworkManager.sharedManager.getImageFromURL(activity.user.avatarUrl).startWithNext { self.avatarImgView.image = $0 }
        userNameLabel.text = activity.user.username
        repoNameLabel.text = activity.repo.name
        eventTypeLabel.text = activity.eventType.description
        dateLabel.text = activity.createdAt?.makeDateString()
        
    }

}

class DetailViewController: UIViewController, ViewConfigurable {
    
    var activity: Activity!
    
    @IBOutlet weak var avatarImgView: CircularImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var eventTypeLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLayoutSubviews() {
        configureView(forActivity: activity)
    }


    
}
