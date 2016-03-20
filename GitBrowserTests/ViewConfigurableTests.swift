//
//  ViewConfigurableTests.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 3/20/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import XCTest
@testable import GitBrowser
class ViewConfigurableTests: XCTestCase {
    
    struct MockViewModel: ViewConfigurable {
        weak var avatarImgView: CircularImageView! = CircularImageView()
        weak var userNameLabel: UILabel! = UILabel()
        weak var repoNameLabel: UILabel! = UILabel()
        weak var eventTypeLabel: UILabel! = UILabel()
        weak var dateLabel: UILabel!  = UILabel()
        
        
        var usernametext = ""
        var reponametext = ""
        var eventlabeltext = ""
        var datelabeltext = ""
        
        
        mutating func configureView(forActivity activity: Activity) {
            self.usernametext = activity.user.username
            self.reponametext = activity.repo.name
            self.eventlabeltext = activity.eventType.description
            self.datelabeltext = activity.createdAt ?? ""

            
        }
    }
  
    
    func testGivingViewActivityConfiguresView() {
        var v = MockViewModel()
        let mockDictionary = NSDictionary(dictionary: [ "actor" : [
            "avatar_url" : "https://avatars.githubusercontent.com/u/1157147?",
                "gravatar_id": "",
            "id" : 1157147,
            "login" : "NatashaTheRobot",
            "url" : "https://api.github.com/users/NatashaTheRobot" ],
            
            "created_at" : "2016-03-20T10:53:45Z",
            "id" :  3785208708,
            "payload" : [
                "action" : "started"
            ],
            "public" : 1,
            
            "repo" : [
                "id" : 54101275,
                "name" : "SwiftStudies/Duration",
                "url": "https://api.github.com/repos/SwiftStudies/Duration"],
            
            "type" : "WatchEvent"
            ])
        let a = Activity(fromDictionary: mockDictionary )
        
        
        
        v.configureView(forActivity: a)
        
        
        XCTAssertEqual(a.user.username, "NatashaTheRobot")
        XCTAssertEqual(v.usernametext, "NatashaTheRobot")
        XCTAssertEqual(v.datelabeltext, "2016-03-20T10:53:45Z")
        XCTAssertEqual(v.reponametext, "SwiftStudies/Duration")
        XCTAssertEqual(v.eventlabeltext, "Watching")

    }
}

