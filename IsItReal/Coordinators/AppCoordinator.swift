//
//  AppCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 14/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        cordinateToTabBar()
    }
    
    private func cordinateToTabBar() {
        let tabBarCordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCordinator)       
    }
    
}
