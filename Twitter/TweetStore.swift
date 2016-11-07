//
//  TweetStore.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/7/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import Foundation
import UIKit

class TweetStore {
    
    var tweets: [Tweet]!
    
    func loadMoreTweets(refreshControl: UIRefreshControl?) {
        
    }
    
    func getTweets() -> [Tweet] {
        return tweets
    }
}
