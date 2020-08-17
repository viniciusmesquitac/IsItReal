//
//  TabBarCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let tabBarController = UIStoryboard.instantiateTabBarController()

        tabBarController.coordinator = self
        
        let historyListController = UINavigationController()
        historyListController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let historyListCoordinator = HistoryListCordinator(navigationController: historyListController)
        
        let analyseTweetController = UINavigationController()
        analyseTweetController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let analyseTweetCoordinator = AnalyseTweetCoordinator(navigationController: analyseTweetController)
        
        tabBarController.viewControllers = [analyseTweetController, historyListController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: historyListCoordinator)
        coordinate(to: analyseTweetCoordinator)
    }

}
