//
//  TableViewBase.swift
//  Twitter
//
//  Created by Rahul Pandey on 11/6/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit

class TableBaseView: NSObject, UITableViewDataSource {
    
    var tweets: [Tweet]!
    
    func hello() {
        print("hello")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
