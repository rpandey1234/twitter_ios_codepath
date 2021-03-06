//
//  TwitterClient.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "7QyKHYbGKH4KfBCw4Uy78rO0M", consumerSecret: "5uBfjPlkIdYxCSCSJ7dg7qMv9XtFMm2iSIXl65YVc9mBn6zOaW")
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func homeTimeline(maxId: String?, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        var parameters: [String:String]?
        if let maxId = maxId {
            parameters = ["max_id": maxId]
        } else {
            parameters = nil
        }
        get("1.1/statuses/home_timeline.json", parameters: parameters, progress: nil,
            
            success: { (task: URLSessionDataTask, response: Any?) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                success(tweets)
            },
            
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
    
    func profileStatuses(maxId: String?, screenName: String?, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        var parameters: [String:String] = [:]
        if let maxId = maxId {
            parameters = ["max_id": maxId]
        }
        if let screenName = screenName {
            parameters["screen_name"] = screenName
        }
        get("1.1/statuses/user_timeline.json", parameters: parameters, progress: nil,
            
            success: { (task: URLSessionDataTask, response: Any?) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                success(tweets)
        },
            
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        }
        )
    }
    
    func mentionsTimeline(maxId: String?, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        var parameters: [String:String] = [:]
        if let maxId = maxId {
            parameters = ["max_id": maxId]
        }
        get("1.1/statuses/mentions_timeline.json", parameters: parameters, progress: nil,
        
        success: { (task: URLSessionDataTask, response: Any?) in
        let dictionaries = response as! [NSDictionary]
        let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        },
        
        failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        )

    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                success(user)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            if let token = requestToken?.token {
                let authorizeUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                UIApplication.shared.openURL(authorizeUrl)
            }
            }, failure: { (error: Error?) in
                self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(User.userDidLogoutNotification), object: nil, userInfo: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.sharedInstance?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            self.currentAccount(success: { (user: User) in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
            })
            }, failure: { (error: Error?) in
                self.loginFailure?(error!)
        })
    }
    
    func favorite(tweet: Tweet, favorite: Bool) {
        let endpoint = "1.1/favorites/\(favorite ? "create.json" : "destroy.json")?id=\(String(tweet.id))"
        post(endpoint, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
                // do nothing
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("error: \(error.localizedDescription)")
        })
    }
    
    func retweet(tweet: Tweet, retweet: Bool) {
        let endpoint = "1.1/statuses/\(retweet ? "retweet" : "unretweet")/\(String(tweet.id)).json"
        post(endpoint, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            // do nothing
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("error: \(error.localizedDescription)")
        })
    }
    
    func tweet(status: String, success: @escaping (URLSessionDataTask, Any?) -> Void) {
        let endpoint = "https://api.twitter.com/1.1/statuses/update.json"
        let parameters: [String:String] = ["status": status]
        post(endpoint, parameters: parameters, progress: nil, success: success) { (task: URLSessionDataTask?, error: Error) in
            print("error: \(error.localizedDescription)")
        }
    }
}
