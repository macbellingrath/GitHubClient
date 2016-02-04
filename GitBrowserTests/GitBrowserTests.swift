//
//  GitBrowserTests.swift
//  GitBrowserTests
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import XCTest
@testable import GitBrowser

class GitBrowserTests: XCTestCase {
    
    class MockRegistrar: PushNotificationRegistrar {
        var registered = false
        
        func registerUserNotificationSettings() {
            registered = true
        }
    }
    
    func testControllerRegistersForNotificationsAfterSettingAUser() {
        
        let registrar = MockRegistrar()
        var controller = PushNotificationController(registrar: registrar)
        controller.user = User(un: "")
        
        XCTAssertTrue(registrar.registered)
    }
    
}



protocol PushNotificationRegistrar {
    func registerUserNotificationSettings()
}

struct PushNotificationController {
    let registrar: PushNotificationRegistrar
    init(registrar: PushNotificationRegistrar) {
        self.registrar = registrar
    }
    
    var user: User? {
        didSet {
            registrar.registerUserNotificationSettings()
        }
    }
}