//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/28/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorHandleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            authorLabel.text = tweet.user?.name
            if let handle = tweet.user?.screenName {
                authorHandleLabel.text = "@" + handle
            }
            contentLabel.text = tweet.text
            if let imageUrl = tweet.user?.profileUrl {
                userImageView.setImageWith(imageUrl)
            }
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
