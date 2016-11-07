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
    var profileBackgroundUrl: URL?
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        let profileImageString = dictionary["profile_image_url_https"] as? String
        if let profileImageString = profileImageString {
            profileUrl = URL(string: profileImageString)
        }
        let profileBackgroundString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundString = profileBackgroundString {
            profileBackgroundUrl = URL(string: profileBackgroundString)
        }
        screenName = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        
    }
    
    static let userDidLogoutNotification: String = "UserDidLogout"
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
