//
//  UIStoryboard.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - Storyboards
    private static var tabBar: UIStoryboard {
        return UIStoryboard(name: "TabBar", bundle: nil)
    }
    
    private static var analyse: UIStoryboard {
        return UIStoryboard(name: "Analyse", bundle: nil)
    }
    
    private static var history: UIStoryboard {
        return UIStoryboard(name: "History", bundle: nil)
    }
    
    private static var details: UIStoryboard {
        return UIStoryboard(name: "Details", bundle: nil)
    }
    
    private static var onboard: UIStoryboard {
        return UIStoryboard(name: "Onboarding", bundle: nil)
    }
    
    private static var results: UIStoryboard {
        return UIStoryboard(name: "TweetsResults", bundle: nil)
    }
    
    static func instantiateTabBarController() -> TabBarViewController {
        if let vc = tabBar.instantiateViewController(withIdentifier: "tabbarController") as? TabBarViewController {
            return vc
        }
        return TabBarViewController()
    }
    
    static func instantiateHistoryListViewController() -> HistoryListViewController {
        if let vc = history.instantiateViewController(withIdentifier: "historyViewController") as? HistoryListViewController {
            return vc
        }
        return HistoryListViewController()
    }
    
    static func instantiateAnalyseTweetViewController() -> AnalyseTweetViewController {
        if let vc = analyse.instantiateViewController(withIdentifier: "analyseViewController") as? AnalyseTweetViewController {
            return vc
        }
        return  AnalyseTweetViewController()
    }
    
    static func instantiateTweetDetailsViewController() -> TweetDetailsViewController {
        if let vc = details.instantiateViewController(withIdentifier: "TweetDetails") as? TweetDetailsViewController {
            return vc
        }
        return  TweetDetailsViewController()
    }
    
    static func instantiateOnboarding() -> ModalDismissViewController {
        if let vc = onboard.instantiateViewController(withIdentifier: "Onboarding") as? ModalDismissViewController {
            return vc
        }
        return ModalDismissViewController()
    }
    
    static func instantiateLatestResults() -> TweetsResultsListController {
        if let vc = results.instantiateViewController(identifier: "TweetsResults") as? TweetsResultsListController {
            return vc
        }
        return TweetsResultsListController()
    }
}
