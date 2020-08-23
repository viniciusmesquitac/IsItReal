//
//  UserDefaultsManager.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 23/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

enum FirstLaunchState {
    case firstLaunch
    case notFirstLaunch
}

struct UserDefaultsManager {
    
    static func verifyState(completion: (FirstLaunchState) -> ()) {
        let userDefaults = UserDefaults.standard
        
        if UserDefaults.standard.bool(forKey: "firstLaunch") != true {
            userDefaults.set(true, forKey: "firstLaunch")
            completion(.firstLaunch)
            return
        }
        completion(.notFirstLaunch)
    }
}
