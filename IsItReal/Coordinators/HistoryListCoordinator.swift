//
//  HistoryListCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 14/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        
    }
    
}
