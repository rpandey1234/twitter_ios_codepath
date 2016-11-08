//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/28/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var delegate: userImageTapDelegate?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var authorHandleLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func setTintedImage(imageView: UIImageView, filename: String, color: UIColor) {
        let origImage = UIImage(named: filename);
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.image = tintedImage
        imageView.tintColor = color
    }
    
    var tweet: Tweet! {
        didSet {
            contentLabel.text = tweet.text
            authorLabel.text = tweet.user?.name
            if let handle = tweet.user?.screenName {
                authorHandleLabel.text = "@" + handle
            }
            if let imageUrl = tweet.user?.profileUrl {
                userImageView.setImageWith(imageUrl)
                userImageView.layer.cornerRadius = 6
                userImageView.layer.borderColor = UIColor.lightGray.cgColor
                userImageView.layer.borderWidth = 2.0
                userImageView.clipsToBounds = true
            }
            setTintedImage(imageView: replyImageView, filename: "reply", color: UIColor.lightGray)
            let colorRetweet = tweet.hasRetweeted ? UIColor.green : UIColor.lightGray
            setTintedImage(imageView: retweetImageView, filename: "retweet", color: colorRetweet)
            let colorFav = tweet.hasFavorited ? UIColor.yellow : UIColor.lightGray
            setTintedImage(imageView: favoriteImageView, filename: "star", color: colorFav)
            if let timestamp = tweet.timestamp {
                timestampLabel.text = timestamp.timeAgoSimple
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(onImageTap))
            userImageView.addGestureRecognizer(tap)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        authorHandleLabel.preferredMaxLayoutWidth = authorHandleLabel.frame.size.width
        // Initialization code
    }
    
    func onImageTap(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.userImageTapDelegate(user: tweet.user!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorHandleLabel.preferredMaxLayoutWidth = authorHandleLabel.frame.size.width
    }
}

protocol userImageTapDelegate {
    func userImageTapDelegate(user: User)
}
