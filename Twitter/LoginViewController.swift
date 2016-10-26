//
//  LoginViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/25/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonClicked(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "7QyKHYbGKH4KfBCw4Uy78rO0M", consumerSecret: "5uBfjPlkIdYxCSCSJ7dg7qMv9XtFMm2iSIXl65YVc9mBn6zOaW")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
                print("success, got token \(requestToken?.token)")
            if let token = requestToken?.token {
                let authorizeUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                UIApplication.shared.openURL(authorizeUrl)
            }

            
            }, failure: { (error: Error?) in
                print("error: \(error?.localizedDescription)")
        })
        print("hello")
    }
}
