//
//  CustomTabBarController.swift
//  FBMessanger
//
//  Created by Alaa_Naji on 7/19/16.
//  Copyright © 2016 Alaa_Naji. All rights reserved.
//

import UIKit
class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let friend = FriendController(collectionViewLayout: layout)
        let recent = UINavigationController(rootViewController: friend)
        recent.tabBarItem.title = "Recent"
        viewControllers = [recent,makeNav("Groups"),makeNav("Calls"),makeNav("People"),makeNav("Settings")]
    }
    func makeNav(title:String) -> UINavigationController {
        let view = UIViewController()
        let nav = UINavigationController(rootViewController: view)
        nav.tabBarItem.title = title
        return nav
    }
}
