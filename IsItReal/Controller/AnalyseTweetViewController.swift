//
//  AnallyseTweetViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
import Swifter

class AnalyseTweetViewController: UIViewController {
    
    @IBOutlet weak var imageToAnalyse: UIImageView!
    var imageUrl: URL?
    let imageReader = ImageReader()
    let imagePickerWorker = ImagePickerWorker()
    let viewModel = AnalysesTweetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagePickerWorker()
        updateViewModel()
    }
    
    fileprivate func setupImagePickerWorker() {
        imagePickerWorker.delegate = self
        
        imagePickerWorker.didSelectImage = { image, url in
            self.imageToAnalyse.image = image
            self.imageUrl = url
        }
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleUpdate = { 
            // show loading
        }
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        imagePickerWorker.start()
    }
    
    @IBAction func didTapSelectAnalyseButton(_ sender: Any) {
        guard let url = imageUrl else { return viewModel.failureHandler(self, error: .notImage) }
        
        let results = imageReader.perform(on: url, recognitionLevel: .fast)
        // Identify results to text, username, screenName.
        let query = imageReader.createQuery(text: results)
        // Handle query in view Model
        let queryText = viewModel.handleQueryResults(query)
        // Search with queryText
        SwifterService.shared.searchTweet(query: queryText, presentFrom: self) { (tweets) in
            self.viewModel.saveTweets(tweets: tweets)
            self.viewModel.alert(self, title: "Success", message: "Tweet was saved in your history")
        }
    }
}
