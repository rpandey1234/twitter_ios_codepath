//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    var isMoreDataLoading = false
    var tweets: [Tweet]!
    var loadingMoreView: InfiniteScrollActivityView?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        getTweets(refreshControl: nil)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getTweets(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    func getTweets(refreshControl: UIRefreshControl?) {
        var maxId: String? = nil
        if let tweets = tweets {
            if !tweets.isEmpty {
                maxId = String(tweets[tweets.count - 1].id)
            }
        }
        if refreshControl != nil {
            maxId = nil
        }
        TwitterClient.sharedInstance?.homeTimeline(maxId: maxId, success: { (tweets: [Tweet]) in
                if (maxId != nil) {
                    for (index, tweet) in tweets.enumerated() {
                        if index != 0 {
                            self.tweets.append(tweet)
                        }
                    }
                } else {
                    self.tweets = tweets
                }
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
                self.tableView.reloadData()
                if let refreshControl = refreshControl {
                    refreshControl.endRefreshing()
                }
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
                self.isMoreDataLoading = false
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate position of one screen length before the bottom of results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging {
                isMoreDataLoading = true
                // Update position of loadingMoreView, and start loading indicator
                 let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                getTweets(refreshControl: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if (identifier == "composeSegue") {
                let navController = segue.destination as! UINavigationController
                let composeVc = navController.topViewController as! ComposeViewController
                composeVc.user = User.currentUser
            } else if (identifier == "detailTweet") {
                let navController = segue.destination as! UINavigationController
                let detailVc = navController.topViewController as! SingleViewController
                detailVc.tweet = sender as? Tweet
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let detailTweet = tweets[row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "detailTweet", sender: detailTweet)
            
        }
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
