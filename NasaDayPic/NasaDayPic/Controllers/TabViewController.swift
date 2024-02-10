//
//  TabViewController.swift
//  NasaDayPic
//
//  Created by Anita Stashevskaya on 09.02.2024.
//

import Foundation
import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllersTabs()
    }

    private func setupViewControllersTabs() {
        let apodVC = APODViewController()
        let searchVC = SearchViewController()
        
        let nav1 = UINavigationController(rootViewController: apodVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Astronomy Picture Of a Day", image: UIImage(systemName: "star"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
