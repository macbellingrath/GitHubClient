//
//  EventTypeExtensions.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/28/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation


extension EventType {
    
    var description: String {
        switch self {
        case .Unknown: return "Unknown"
        case .CreateEvent: return "Created"
        case .ForkEvent: return  "Forked"
        case .MemberEvent: return "Created"
        case .WatchEvent: return "Watching"
        }
    }
}