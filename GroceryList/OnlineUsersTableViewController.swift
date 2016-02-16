//
//  OnlineUsersTableViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 16.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class OnlineUsersTableViewController: UITableViewController {
    
    var currentUsers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUsers.append("hungry@person.food")
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentUsers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let onlineUserEmail = currentUsers[indexPath.row]
        cell.textLabel?.text = onlineUserEmail
        return cell
    }
    
}
