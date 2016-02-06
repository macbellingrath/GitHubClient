//
//  AppDelegate.swift
//  GitBrowser
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        guard url.host == "com.macbellingrath.gitbrowser" else { return false }
        OAuthSwift.handleOpenURL(url)
        return true
    }

}