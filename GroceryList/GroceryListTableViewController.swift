//
//  GroceryListTableViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 10.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase

class GroceryListTableViewController: UITableViewController {
    
    var items = [GroceryItem]()
    var user: User!
    
    private var myRootRef = Firebase(url:"https://luminous-torch-8558.firebaseio.com")

    @IBAction func addButtonPressed(sender: AnyObject) {
        // Alert View for input
        let alert = UIAlertController(title: "Grocery Item",
            message: "Add an Item",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] 
                let groceryItem = GroceryItem(name: textField.text!, addedByUser: self.user.email, completed: false)
                
                
                let groceryItemRef = self.myRootRef.childByAppendingPath(textField.text!.lowercaseString)
                groceryItemRef.setValue(groceryItem.toAnyObject())
                
                //self.items.append(groceryItem)
                //self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User(uid: "FakeId", email: "hungry@person.food")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //myRootRef.observeEventType(.Value, withBlock: { snapshot in
        myRootRef.queryOrderedByChild("completed").observeEventType(.Value, withBlock: { snapshot in
            
            var newItems = [GroceryItem]()
            
            for item in snapshot.children {
                let groceryItem = GroceryItem(snapshot: item as! FDataSnapshot)
                newItems.append(groceryItem)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
        myRootRef.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
            }
        }
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
        return items.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let groceryItem = items[indexPath.row]
        
        cell.textLabel?.text = groceryItem.name
        cell.detailTextLabel?.text = groceryItem.addedByUser
        
        // Determine whether the cell is checked
        toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Find the snapshot and remove the value
            let groceryItem = items[indexPath.row]
            groceryItem.ref?.removeValue()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let groceryItem = items[indexPath.row]
        let toggledCompletion = !groceryItem.completed
        
        // Determine whether the cell is checked
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        
        groceryItem.ref?.updateChildValues(["completed": toggledCompletion])
    }
    

    // MARK: - Supporting functions
    
    func toggleCellCheckbox(cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.detailTextLabel?.textColor = UIColor.grayColor()
        }
    }

}
