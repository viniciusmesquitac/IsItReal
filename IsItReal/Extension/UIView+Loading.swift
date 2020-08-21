//
//  UIView+Loading.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 21/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol LoadingProtocol: class {
    func setLoading(_ loading: Bool)
}

extension UIView: LoadingProtocol {
    
    private var indicator: UIActivityIndicatorView {
        if let indicator = subviews.compactMap({$0 as? UIActivityIndicatorView }).first {
            return indicator
        } else {
            let indicator = UIActivityIndicatorView(style: .medium)
            addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            indicator.color = tintColor
            indicator.hidesWhenStopped = true
            return indicator
        }
    }
    
    @objc func setLoading(_ loading: Bool) {
        switch loading {
        case true:
            indicator.startAnimating()
        case false:
            indicator.stopAnimating()
        }
    }
    
    func triggerLoading(in target: LoadingProtocol, duration: TimeInterval = 0.5) {
        target.setLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            target.setLoading(false)
        }
    }
}
