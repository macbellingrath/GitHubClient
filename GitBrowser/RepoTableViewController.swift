//
//  RepoTableViewController.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit
import ReactiveCocoa


class RepoTableViewController: UITableViewController {
    
    var activities: [Activity] = []
    
    var currentUser: User = User(un: "macbellingrath")
    
    func configureView() {
        currentUserFeedLabel.text = "Viewing " + currentUser.username + "'s public feed"
        
        NetworkManager.sharedManager.fetchActivity(forUser: currentUser).startWithNext { self.activities = $0 ; self.tableView.reloadData()}
        
    }

    @IBOutlet weak var currentUserFeedLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configureView()
        
        
        let cellNib = UINib(celltype: .CardTableViewCell)
        
        tableView.registerNib(cellNib, forCellReuseIdentifier: UITableViewCellIdentifier.CardTableViewCell.rawValue)
        
        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return activities.count
    }
    
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifierForSegue {
        case .Default: break
        case .Detail:
                guard let row = tableView.indexPathForSelectedRow?.row, let destVC = segue.destinationViewController as? DetailViewController else { return }
          
            destVC.activity = activities[row]
            
        }
    }
    @IBAction func unwind(sender: UIStoryboardSegue) {
        
        guard let detailVC = sender.sourceViewController as? DetailViewController, let activity = detailVC.activity else { return }
        
        currentUser = activity.user
        configureView()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCellWithIdentifier(UITableViewCellIdentifier.CardTableViewCell.rawValue, forIndexPath: indexPath) as! CardTableViewCell
        
        
        let activity = activities[indexPath.row]
        cell.usernameLabel.text = activity.user.username
        cell.topTextLabel.text = activity.repo.name
    
        cell.bottomTextLabel.text = activity.createdAt?.makeDateString()
        let eventstr: String
        switch activity.eventType {
        case .Unknown: eventstr = "Unknown"
        case .ForkEvent: eventstr = "Forked"
        case .MemberEvent: eventstr = "Created"
        case .WatchEvent: eventstr = "Watching"
        }
         cell.eventTypeTextLabel.text = eventstr
       
        
        print(activity.type)

        NetworkManager.sharedManager.getImageFromURL(activity.user.avatarUrl).startWithNext {
            
            cell.avatarimgview.image = $0; cell.avatarimgview.makeRound()
        }
        

        return cell 
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueIdentifierType.Detail.rawValue, sender: self)
    }


  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }

}


