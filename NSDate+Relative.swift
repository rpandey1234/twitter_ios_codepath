//
//  NSDate+Relative.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/29/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import Foundation

extension NSDate {
    // Adapted from https://github.com/kevinlawler/NSDate-TimeAgo/blob/master/NSDate%2BExtension.swift#L76
    public var timeAgoSimple: String {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self as Date, to: Date())
        if components.year! > 0 {
            return "\(components.year!)yr"
        }
        
        if components.month! > 0 {
            return "\(components.month!)w"
        }
        
        // TODO: localize for other calanders
        if components.day! >= 7 {
            let value = components.day!/7
            return "\(value)w"
        }
        
        if components.day! > 0 {
            return "\(components.day!)d"
        }
        
        if components.hour! > 0 {
            return "\(components.hour!)h"
        }
        
        if components.minute! > 0 {
            return "\(components.minute!)m"
        }
        
        if components.second! > 0 {
            return "\(components.second!)s"
        }
        return ""
    }
}
