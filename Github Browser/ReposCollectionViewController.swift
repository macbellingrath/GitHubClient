//
//  ReposCollectionViewController.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/7/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ReposCollectionViewController: UICollectionViewController {
    
    
    var activities: [Activity] = []
    
    var currentUser: User = User(un: "macbellingrath")
    
    func configureView() {
   
        
        NetworkManager.sharedManager.fetchActivity(forUser: currentUser).startWithNext { self.activities = $0 ; self.collectionView?.reloadData()}
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifierForSegue {
        case .Default: fatalError("segue id error")
        case .Detail:

            guard let item = collectionView?.indexPathsForSelectedItems()?.first?.item, let destVC = segue.destinationViewController as? DetailViewController else { fatalError("no item") }
            
            destVC.activity = activities[item]
            
        }

    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return activities.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RepoCollectionViewCell
        
        cell.configureView(forActivity: activities[indexPath.item])

    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueIdentifierType.Detail.rawValue, sender: self)
    }

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    
}
