//
//  NIBExtensions.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/28/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit

extension UINib {
    convenience init(celltype: UITableViewCellIdentifier) {
        self.init(nibName: celltype.rawValue, bundle: nil)
    }
}
