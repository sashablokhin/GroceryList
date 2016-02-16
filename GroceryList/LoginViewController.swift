//
//  ViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 10.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    private let myRootRef = Firebase(url:"https://luminous-torch-8558.firebaseio.com/grocery_list")
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        myRootRef.authUser(emailTextField.text, password: passwordTextField.text,
            withCompletionBlock: { (error, auth) in
                
        })
    }
    
    
    @IBAction func signupButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
            message: "Register",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let emailField = alert.textFields![0] 
                let passwordField = alert.textFields![1] 
                
                self.myRootRef.createUser(emailField.text, password: passwordField.text) { (error: NSError!) in
                    if error == nil {
                        self.myRootRef.authUser(emailField.text, password: passwordField.text,
                            withCompletionBlock: { (error, auth) -> Void in
                        })
                    }
                }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textEmail) -> Void in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textPassword) -> Void in
            textPassword.secureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5.0
        loginButton.clipsToBounds = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        /*
        // Create a reference to a Firebase location
        var myRootRef = Firebase(url:"https://luminous-torch-8558.firebaseio.com")
        // Write data to Firebase
        myRootRef.setValue("Do you have data? You'll love Firebase.")
        
        
        // Read data and react to changes
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })*/
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        myRootRef.observeAuthEventWithBlock { (authData) -> Void in
            if authData != nil {
                self.performSegueWithIdentifier("showTabs", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

