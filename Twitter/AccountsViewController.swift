//
//  AccountsViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/7/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = User.currentUser?.name
        if let handle = User.currentUser?.screenName {
            userHandle.text = "@" + handle
        }
    }

    @IBAction func onTapAddButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            // TODO: should add account here
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
    }
}
