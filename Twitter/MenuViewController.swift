//
//  MenuViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/2/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var homeNavigationController: UIViewController!
    private var profileNavigationController: UIViewController!
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        homeNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsViewController")
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        viewControllers.append(homeNavigationController)
        viewControllers.append(profileNavigationController)
        
        hamburgerViewController.contentViewController = homeNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let titles = ["Home", "Profile"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
