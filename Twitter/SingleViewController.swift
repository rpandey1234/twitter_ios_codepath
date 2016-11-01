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
            }
            setTintedImage(imageView: replyImageView, filename: "reply", color: UIColor.lightGray)
            setTintedImage(imageView: retweetImageView, filename: "retweet", color: UIColor.lightGray)
            setTintedImage(imageView: favoriteImageView, filename: "star", color: UIColor.lightGray)
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
