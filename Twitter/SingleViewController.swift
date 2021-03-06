//
//  SingleViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/29/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    var tweet: Tweet?
    
    func setTintedImage(imageView: UIImageView, filename: String, color: UIColor) {
        let origImage = UIImage(named: filename);
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.image = tintedImage
        imageView.tintColor = color
    }
    
    @IBAction func didTapUserImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "userProfile", sender: tweet?.user)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tweet = tweet {
            contentLabel.text = tweet.text
            realNameLabel.text = tweet.user?.name
            if let handle = tweet.user?.screenName {
                userHandleLabel.text = "@" + handle
            }
            if let imageUrl = tweet.user?.profileUrl {
                avatarImageView.setImageWith(imageUrl)
                avatarImageView.layer.cornerRadius = 6
                avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
                avatarImageView.layer.borderWidth = 2.0
                avatarImageView.clipsToBounds = true
            }
            setTintedImage(imageView: replyImageView, filename: "reply", color: UIColor.lightGray)
            let colorRetweet = tweet.hasRetweeted ? UIColor.green : UIColor.lightGray
            setTintedImage(imageView: retweetImageView, filename: "retweet", color: colorRetweet)
            let colorFav = tweet.hasFavorited ? UIColor.yellow : UIColor.lightGray
            setTintedImage(imageView: favoriteImageView, filename: "star", color: colorFav)
            
            // todo: format these as human readable
            favoriteCountLabel.text = String(tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            if let timestamp = tweet.timestamp {
                let formatter = DateFormatter()
                formatter.dateStyle = DateFormatter.Style.long
                formatter.timeStyle = .medium
                timeStampLabel.text = formatter.string(from: timestamp as Date)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if (identifier == "composeSegue") {
                let navController = segue.destination as! UINavigationController
                let composeVc = navController.topViewController as! ComposeViewController
                if let replyHandle = tweet?.user?.screenName {
                    composeVc.prefillText = "@" + replyHandle + " "
                }
                composeVc.user = User.currentUser
            } else if (identifier == "userProfile") {
                let navController = segue.destination as! UINavigationController
                let profileVc = navController.topViewController as! ProfileViewController
                profileVc.user = sender as? User
            }
        }
    }

    @IBAction func onReplyTap(_ sender: AnyObject) {
        performSegue(withIdentifier: "composeSegue", sender: tweet)
    }
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        if let tweet = tweet {
            tweet.hasRetweeted = !tweet.hasRetweeted
            tweet.retweetCount += tweet.hasRetweeted ? 1 : -1
            retweetCountLabel.text = String(tweet.retweetCount)
            let colorRetweet = tweet.hasRetweeted ? UIColor.green : UIColor.lightGray
            setTintedImage(imageView: retweetImageView, filename: "retweet", color: colorRetweet)
            TwitterClient.sharedInstance?.retweet(tweet: tweet, retweet: tweet.hasRetweeted)
        }
    }
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        if let tweet = tweet {
            tweet.hasFavorited = !tweet.hasFavorited
            tweet.favoriteCount += tweet.hasFavorited ? 1 : -1
            favoriteCountLabel.text = String(tweet.favoriteCount)
            let colorFav = tweet.hasFavorited ? UIColor.yellow : UIColor.lightGray
            setTintedImage(imageView: favoriteImageView, filename: "star", color: colorFav)
            TwitterClient.sharedInstance?.favorite(tweet: tweet, favorite: tweet.hasFavorited)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onHomeTap(_ sender: AnyObject) {
        dismiss(animated: true)
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
