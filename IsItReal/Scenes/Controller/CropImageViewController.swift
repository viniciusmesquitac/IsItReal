//
//  CropImageViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 05/09/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class CropImageViewController: UIViewController {
    
    var imageUrl: URL?
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            imageView.image = image
        }
    }
}
