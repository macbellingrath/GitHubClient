//
//  Secrets.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/5/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation

struct GitHubSecrets {
    static let clientID = "439f6afe0bd9bfaae9bc"
    static let clientSecret = "bb33ce01645e059889b392db010b5f7d421a731e"
    static let authorizationcallback = NSURL(string:"com.macbellingrath.gitbrowser")!
    static let gitHubOAuthEndPoint = "https://github.com/login/oauth/authorize"
    
}

struct Notifications {
    static let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"
} 