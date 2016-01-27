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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User(un: "macbellingrath")
        
        NetworkManager.sharedManager.fetchActivity(forUser: user).startWithNext { self.activities = $0 ; self.tableView.reloadData()}
        
        
          let cellNib = UINib(nibName: "CardTableViewCell", bundle: nil)
        
        tableView.registerNib(cellNib, forCellReuseIdentifier: "CardTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCellWithIdentifier("CardTableViewCell", forIndexPath: indexPath) as! CardTableViewCell
        
        
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

        NetworkManager.sharedManager.getImageFromURL(activity.user.avatarUrl).startWithNext { cell.avatarimgview.image = $0 }
        

        return cell 
    }

  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }

}

extension String {
    func makeDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.dateFromString(self) else { return "" }
        let prettydateformatter = NSDateFormatter()
        prettydateformatter.dateStyle = .ShortStyle
        prettydateformatter.timeStyle = .ShortStyle
        return prettydateformatter.stringFromDate(date)
    }
}
