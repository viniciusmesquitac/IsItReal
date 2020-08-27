//
//  UserDefaultsManager.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 23/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Swifter

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
    
    static func getAuthToken() -> Credential.OAuthAccessToken? {
        guard let key = UserDefaults.standard.string(forKey: "authKey"),
            let secret = UserDefaults.standard.string(forKey: "authSecret") else { return nil }
        let credential = Credential.OAuthAccessToken(key: key, secret: secret)
        print("key: \(credential.key) \n secret: \(credential.secret)")
        return credential
    }
    
    static func setAuthToken(key: String?, secret: String?) {
        guard let key = key, let secret = secret else { return }
        UserDefaults.standard.setValue(key, forKey: "authKey")
        UserDefaults.standard.setValue(secret, forKey: "authSecret")
    }
}
