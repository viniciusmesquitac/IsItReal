//
//  UIButton+Loading.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 21/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

fileprivate var key: UInt8 = 42

extension UIButton {
    
    private var title: String? {
        get {
            objc_getAssociatedObject(self, &key) as? String
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    override func setLoading(_ loading: Bool) {
        super.setLoading(loading)
        
        if title == nil {
            title = currentTitle
        }
        
        switch loading {
        case true:
            self.setTitle(nil, for: .normal)
        case false:
            self.setTitle(title, for: .normal)
        }
        
    }
    
}
