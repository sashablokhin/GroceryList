//
//  ViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 10.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    

    @IBAction func loginButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showGroceryList", sender: self)
    }
    
    
    @IBAction func signupButtonPressed(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5.0
        loginButton.clipsToBounds = true
        
        // Create a reference to a Firebase location
        var myRootRef = Firebase(url:"https://luminous-torch-8558.firebaseio.com")
        // Write data to Firebase
        myRootRef.setValue("Do you have data? You'll love Firebase.")
        
        
        // Read data and react to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

