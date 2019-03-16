//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Mitul Manish on 17/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r = UIViewController()
        r.view.backgroundColor = .white
        r.navigationItem.title = "Apps"
        let rNavBarController = UINavigationController(rootViewController: r)
        rNavBarController.tabBarItem.title = "Apps"
        rNavBarController.navigationBar.prefersLargeTitles = true
        rNavBarController.tabBarItem.image = UIImage(named: "apps")
        
        let g = UIViewController()
        g.view.backgroundColor = .white
        g.navigationItem.title = "Search"
        let gNavBarController = UINavigationController(rootViewController: g)
        gNavBarController.tabBarItem.title = "Search"
        gNavBarController.navigationItem.title = "Search"
        gNavBarController.navigationBar.prefersLargeTitles = true
        gNavBarController.tabBarItem.image = UIImage(named: "search")
        
        viewControllers = [rNavBarController, gNavBarController]
    }
}
