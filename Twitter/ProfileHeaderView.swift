//
//  ProfileHeaderView.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/6/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var user: User! {
        didSet {
            nameLabel.text = user.name
            if let handle = user.screenName {
                handleLabel.text = "@" + handle
            }
            if let imageUrl = user.profileUrl {
                userImageView.setImageWith(imageUrl)
                userImageView.layer.cornerRadius = 8
                userImageView.layer.borderColor = UIColor.white.cgColor
                userImageView.layer.borderWidth = 3.0
                userImageView.clipsToBounds = true
            }
            if let backgroundImageUrl = user.profileBackgroundUrl {
                backgroundImageView.setImageWith(backgroundImageUrl)
            }
            bioLabel.text = user.tagline
            followersLabel.text = String(describing: user.followerCount!)
            followingLabel.text = String(describing: user.followingCount!)
            tweetsLabel.text = String(describing: user.tweetCount!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
