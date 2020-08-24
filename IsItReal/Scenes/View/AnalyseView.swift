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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var analyseButton: UIButton!
    @IBOutlet weak var analyseProButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    func handleButtonsState() {
        if imageUrl != nil {
            selectPhotoButton.setTitle("Change Photo", for: .normal)
            analyseButton.isHidden = false
            analyseProButton.isHidden = false
        }
    }
    
    func setLoadingAnalyseButton(_ bool: Bool) {
        self.analyseButton.setLoading(bool)
        self.analyseButton.isEnabled = !bool
    }
    
    func removeImage() {
        self.image.image = UIImage(named: "LightSampleImage")
        self.imageUrl = nil
    }
    
    func setImage(image: UIImage, url: URL?) {
        self.image.image = image
        self.imageUrl = url
        self.handleButtonsState()
    }
}
