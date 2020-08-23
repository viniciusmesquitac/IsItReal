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
        historyListController.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "􀓕"), tag: 1)
        let historyListCoordinator = HistoryListCordinator(navigationController: historyListController)
        
        let analyseTweetController = UINavigationController()
        analyseTweetController.tabBarItem = UITabBarItem(title: "Analyse", image: UIImage(named: "􀕹"), tag: 0)
        let analyseTweetCoordinator = AnalyseTweetCoordinator(navigationController: analyseTweetController)
        
        tabBarController.viewControllers = [analyseTweetController, historyListController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        UserDefaultsManager.verifyState { state in
            switch state {
            case .firstLaunch:
                 navigationController.present(tabBarController, animated: false, completion: nil)
                 let onboardVC = UIStoryboard.instantiateOnboarding()
                 tabBarController.present(onboardVC, animated: true, completion: nil)
            case .notFirstLaunch:
                navigationController.present(tabBarController, animated: false, completion: nil)
            }
        }
       
        coordinate(to: historyListCoordinator)
        coordinate(to: analyseTweetCoordinator)
    }

}
