//
//  SceneDelegate.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
import Swifter

class SceneDelegate: UIResponder, UIWindowSceneDelegate {


   var window: UIWindow?

   func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
       guard let context = URLContexts.first else { return }
       
       if let callbackUrl = URL(string: "TwitterTestingAPI://") {
           Swifter.handleOpenURL(context.url, callbackURL: callbackUrl)
       }
       
   }

}
