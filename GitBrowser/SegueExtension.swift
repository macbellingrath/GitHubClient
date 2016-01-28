//
//  SegueExtension.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/28/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

enum SegueIdentifierType: String {
    case Default, Detail

}

extension UIStoryboardSegue{
    var identifierForSegue: SegueIdentifierType {
        guard let id = identifier  else { return .Default }
        return SegueIdentifierType(rawValue: id) ?? .Default
    }
}
