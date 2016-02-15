//
//  User.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 15.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//


import Firebase


struct User {
    let uid: String
    let email: String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}