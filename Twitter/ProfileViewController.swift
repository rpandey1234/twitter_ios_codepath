//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/2/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.red
        //        return view
//        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderView") as! ProfileHeaderView
        cell.user = User.currentUser
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
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
