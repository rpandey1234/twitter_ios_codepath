//
//  Tweet.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/26/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var hasRetweeted: Bool = false
    var favoriteCount: Int = 0
    var hasFavorited: Bool = false
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        hasRetweeted = (dictionary["retweeted"] as? Bool) ?? false
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        hasFavorited = (dictionary["favorited"] as? Bool) ?? false
        if let userDictionary = (dictionary["user"] as? NSDictionary) {
            user = User(dictionary: userDictionary)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
