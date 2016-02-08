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
    weak var repoDescriptionTextView: UITextView! { get set }
    
    
}
extension ViewConfigurable {
    
    func configureView(forActivity activity: Activity) {
    NetworkManager.sharedManager.getImageFromURL(activity.user.avatarUrl).startWithNext { self.avatarImgView.image = $0 }
        userNameLabel.text = activity.user.username
        repoNameLabel.text = activity.repo.name
        eventTypeLabel.text = activity.eventType.description
        dateLabel.text = activity.createdAt?.makeDateString()
        repoDescriptionTextView.text = activity.repo.description
        
    }

}

class DetailViewController: UIViewController, ViewConfigurable {
    
    var activity: Activity!
    var repoDetail: RepoDetail!
    
    @IBOutlet weak var avatarImgView: CircularImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var eventTypeLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var repoDescriptionTextView: UITextView!

    override func viewDidLayoutSubviews() {
        configureView(forActivity: activity)
        
        NetworkManager.sharedManager.getRepoDetail(forRepo: activity.repo).zipWith(NetworkManager.sharedManager.fetchActivity(forUser: activity.user)).startWithNext { a,b in
            
        }
        
        NetworkManager.sharedManager.getRepoDetail(forRepo: activity.repo).startWithNext {
            self.repoDetail = $0
            self.repoDescriptionTextView.text = $0.repoDescription
        }
    }

    
}
