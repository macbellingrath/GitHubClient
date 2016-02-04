//
//  ObjectExt.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/4/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveCocoa



class ObjectManager {
    static let sharedManger = ObjectManager()
    
    func getLocalEventsforUser(userToSearch: RealmUser) -> SignalProducer<[RealmActivity], NoError> {
        return SignalProducer { observer,signal in
            
            let realm = try! Realm()

            let predicate = NSPredicate(format: "user.username == %@", userToSearch.username)
            let activities = realm.objects(RealmActivity).filter(predicate).flatMap{$0}
            observer.sendNext(activities)
            observer.sendCompleted()
            
        }
    }
}