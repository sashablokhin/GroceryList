//
//  MainViewController.swift
//  GroceryList
//
//  Created by Alexander Blokhin on 15.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, TabsViewControllerDelegate {
    
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBarHidden = true
        
        titleLabel.textColor = UIColor.whiteColor()
        
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0))
        navigationBar.translucent = false
        navigationBar.barTintColor = navigationController?.navigationBar.barTintColor
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed")
        addButton.tintColor = UIColor.whiteColor()
        
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navItem.rightBarButtonItems = [addButton]
        
        navigationBar.setItems([navItem], animated: true)
        
        //self.view.addSubview(navigationBar)

    }
    
    
    func addButtonPressed() {
        NSNotificationCenter.defaultCenter().postNotificationName("AddGrocery", object: nil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tab1 = TabItem()
        tab1.imageNormal = UIImage(named: "grocery_black")
        tab1.imageActive = UIImage(named: "grocery_white")
        tab1.title = "Grocery List"
        tab1.viewController = GroceryListTableViewController()
        
        let tab2 = TabItem()
        tab2.imageNormal = UIImage(named: "users_black")
        tab2.imageActive = UIImage(named: "users_white")
        tab2.title = "Users"
        tab2.viewController = //GroceryListTableViewController()
        viewControllerWithColor(UIColor.brownColor().colorWithAlphaComponent(0.8))
        
        
        tabsViewController = TabsViewController(parent: self, tabs: [tab1, tab2])
        tabsViewController.view.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height)
        tabsViewController.delegate = self
        
        self.view.addSubview(tabsViewController.view)
        
        tabsViewController.tabsScrollView.appearance.outerPadding = 0
        tabsViewController.tabsScrollView.appearance.innerPadding = view.frame.width / 4 //50
        
        tabsViewController.setCurrentViewControllerAtIndex(0)
        
        self.view.addSubview(navigationBar)
    }
    
    func viewControllerWithColor(color: UIColor) -> UIViewController {
        let viewController = UIViewController()
        
        viewController.view.backgroundColor = color
        
        return viewController
    }
    
    // MARK: - TabsViewControllerDelegate
    
    func tabsViewControllerDidMoveToTab(tabsViewController: TabsViewController, tab: TabItem, atIndex: Int) {
        titleLabel.text = tab.title
        titleLabel.sizeToFit()
    }
    
}
