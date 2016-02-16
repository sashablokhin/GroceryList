//
//  OnlineUsersTableViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 16.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase

class OnlineUsersTableViewController: UITableViewController {
    
    private let usersRef = Firebase(url: "https://luminous-torch-8558.firebaseio.com/online")
    
    var currentUsers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUsers.append("hungry@person.food")
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        usersRef.observeEventType(.ChildAdded, withBlock: { (snap: FDataSnapshot!) in
            self.currentUsers.append(snap.value as! String)
            let row = self.currentUsers.count - 1
            let indexPath = NSIndexPath(forRow: row, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        })
        
        usersRef.observeEventType(.ChildRemoved, withBlock: { (snap: FDataSnapshot!) -> Void in
            let emailToFind: String! = snap.value as! String
            for(index, email) in self.currentUsers.enumerate() {
                if email == emailToFind {
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    self.currentUsers.removeAtIndex(index)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
            }
        })
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
