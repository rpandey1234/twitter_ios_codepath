//
//  User.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/26/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var screenName: String?
    var tagline: String?
    var profileUrl: URL?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        let profileImageString = dictionary["profile_image_url_https"] as? String
        if let profileImageString = profileImageString {
            profileUrl = URL(string: profileImageString)
        }
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
    }
}
