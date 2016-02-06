//
//  Security.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 2/6/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation

class SecurityManager {
    
    func auth() {
    var accessControlError: Unmanaged<CFError>?
    guard let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, SecAccessControlCreateFlags.UserPresence, &accessControlError) else { return print(1) }
    
    let password = "password"
    
    let secret: NSData = password.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    
    let query = [
            String(kSecClass) : kSecClassGenericPassword,
            String(kSecAttrService) : "MyService",
            String(kSecAttrAccount) : "fooUser",
            String(kSecValueData) : secret,
            String(kSecAttrAccessControl) : accessControl
        
        ] as CFDictionary
      
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            
            print("error")
            
        }
    }
}