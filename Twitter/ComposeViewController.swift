//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 10/29/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let user = User.currentUser {
            nameLabel.text = user.name
            handleLabel.text = user.screenName
            if let imageUrl = user.profileUrl {
                pictureImageView.setImageWith(imageUrl)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelTap(_ sender: AnyObject) {
        dismiss(animated: true) {}
    }
    @IBAction func onTweetTap(_ sender: AnyObject) {
        print("tweeting")
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
