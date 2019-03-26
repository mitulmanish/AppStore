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
        let todayNavigationController = createNavController(
            backgroundColor: .white,
            title: "Today",
            tabBarImageName: "today_icon"
        )
        let appsNavigationController = createNavController(
            backgroundColor: .white,
            title: "Apps",
            tabBarImageName: "apps"
        )
        let searchViewController = createNavController(
            viewController:  AppsSearchCollectionViewController(),
            backgroundColor: .white,
            title: "Search",
            tabBarImageName: "search"
        )
        viewControllers = [searchViewController, todayNavigationController, appsNavigationController]
    }
}

extension BaseTabBarController {
    private func createNavController(viewController: UIViewController = UIViewController(), backgroundColor: UIColor, title: String, tabBarImageName: String) -> UINavigationController {
        viewController.view.backgroundColor = backgroundColor
        viewController.navigationItem.title = title
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: tabBarImageName)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
