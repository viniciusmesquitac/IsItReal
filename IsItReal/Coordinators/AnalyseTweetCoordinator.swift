//
//  AnalyseTweetCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol AnalyseTweetCoordinatorDelegate: class {
    func alert()
}

final class AnalyseTweetCoordinator: Coordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard.instantiateAnalyseTweetViewController(delegate: self)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension AnalyseTweetCoordinator: AnalyseTweetViewControllerDelegate {
    func didSwichUserPhoto() {
        print("works fine")
    }
}
