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
    var likeCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        timestamp = dictionary[""] as? NSDate
        likeCount = (dictionary["retweet_count"] as? Int) ?? 0
        retweetCount = (dictionary["favourite_count"] as? Int) ?? 0
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
