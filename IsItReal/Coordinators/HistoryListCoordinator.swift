//
//  HistoryListCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 14/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol HistoryListCoordinatorDelegate: AnyObject {
    func alert()
}

final class HistoryListCordinator: Coordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard.instantiateHistoryListViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showDetails(tweet: TweetDetailsViewModel) {
        let vc = UIStoryboard.instantiateTweetDetailsViewController()
        vc.viewModel = tweet
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
