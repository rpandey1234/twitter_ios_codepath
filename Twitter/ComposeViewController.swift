//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/29/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    var prefillText: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = User.currentUser {
            nameLabel.text = user.name
            if let handle = user.screenName {
                handleLabel.text = "@" + handle
            }
            if let imageUrl = user.profileUrl {
                pictureImageView.setImageWith(imageUrl)
            }
            if let prefillText = prefillText {
                replyTextView.text = prefillText
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        replyTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelTap(_ sender: AnyObject) {
        dismiss(animated: true)
    }
    
    @IBAction func onTweetTap(_ sender: AnyObject) {
        if replyTextView.text.characters.count == 0 {
            print("cannot publish empty tweet")
            return
        }
        TwitterClient.sharedInstance?.tweet(status: replyTextView.text, success: { (task: URLSessionDataTask, response: Any?) in
            self.dismiss(animated: true)
        })
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
