//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {

    var tweets: [Tweet]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
//            for tweet in tweets {
//                print(tweet.text)
//            }
                self.tweets = tweets
            self.tableView.reloadData()
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
