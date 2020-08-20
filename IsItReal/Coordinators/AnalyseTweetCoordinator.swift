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

final class AnalyseTweetCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard.instantiateAnalyseTweetViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showDetails(_ tweet: Tweet) {
        let vc = UIStoryboard.instantiateTweetDetailsViewController()
        vc.tweet = TweetDetailsViewModel(tweet: tweet)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
