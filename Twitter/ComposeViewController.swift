//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/29/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var charsLeftLabel: UIBarButtonItem!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    var prefillText: String?
    var user: User?
    var charLeft: Int = 140
    let CharLimit: Int = 140
    
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
                charLeft = CharLimit - prefillText.characters.count
            }
            charsLeftLabel.title = String(charLeft)
            replyTextView.delegate = self
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        charLeft = CharLimit - textView.text.characters.count
        charsLeftLabel.title = String(charLeft)
        if (charLeft <= 100) {
            charsLeftLabel.tintColor = UIColor.orange
        } else if (charLeft <= 40) {
            charsLeftLabel.tintColor = UIColor.red
        } else {
            charsLeftLabel.tintColor = UIColor.darkGray
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
            let alertController = UIAlertController(title: "Empty Tweet", message: "You cannot publish an empty tweet", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // dismiss by default
            }
            alertController.addAction(OKAction)
            present(alertController, animated: true, completion: {
                // empty
            })
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
