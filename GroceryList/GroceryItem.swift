//
//  GroceryItem.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 15.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//


import Firebase


struct GroceryItem {
    
    let key: String!
    let name: String!
    let addedByUser: String!
    let ref: Firebase?
    var completed: Bool!
    
    // Initialize from arbitrary data
    init(name: String, addedByUser: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        completed = snapshot.value["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "completed": completed
        ]
    }
    
}