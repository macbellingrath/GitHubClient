//
//  StringExtensions.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/28/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation
extension String {
    func makeDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.dateFromString(self) else { return "" }
        let prettydateformatter = NSDateFormatter()
        prettydateformatter.dateStyle = .ShortStyle
        prettydateformatter.timeStyle = .ShortStyle
        return prettydateformatter.stringFromDate(date)
    }
}
