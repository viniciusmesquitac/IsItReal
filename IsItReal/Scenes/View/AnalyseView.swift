//
//  AnalyseView.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 23/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class AnalyseView: UIView {
    var imageUrl: URL?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var analyseButton: UIButton!
    @IBOutlet weak var analyseProButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    func handleButtonsState() {
        if imageUrl != nil {
            selectPhotoButton.setTitle("Change Photo", for: .normal)
            analyseButton.isHidden = false
//            analyseProButton.isHidden = false
        }
    }
    
    func setLoadingAnalyseButton(_ bool: Bool) {
        self.analyseButton.setLoading(bool)
        self.analyseButton.isEnabled = !bool
    }
    
    func removeImage() {
        self.imageView.image = UIImage(named: "LightSampleImage")
        self.imageUrl = nil
    }
    
    func setImage(image: UIImage, url: URL?) {
        self.imageView.image = image
        self.imageUrl = url
        self.handleButtonsState()
    }
    
    func handlePortraidImage() {
        if UIDevice.current.orientation.isLandscape {
            if let image = imageView.image {
                self.imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .up)
            }
        } else {
            if let image = imageView.image {
                self.imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .up)
            }
        
        }
    }
}
