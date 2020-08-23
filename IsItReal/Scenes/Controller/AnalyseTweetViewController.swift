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
    @IBOutlet weak var analyseButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var analyseProButton: UIButton!
    
    var imageUrl: URL?
    let imageReader = ImageReader()
    let imagePickerWorker = ImagePickerWorker()
    let viewModel = AnalysesTweetViewModel()
    var coordinator: AnalyseTweetCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        handleButtonsState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator = AnalyseTweetCoordinator(navigationController: navigationController!)
        setupImagePickerWorker()
        updateViewModel()
    }
    
    fileprivate func setupImagePickerWorker() {
        imagePickerWorker.delegate = self
        imagePickerWorker.didSelectImage = { image, url in
            self.imageToAnalyse.image = image
            self.imageUrl = url
            self.handleButtonsState()
        }
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleSavedTweet = { tweet in
            self.imageToAnalyse.image = UIImage(named: "LightSampleImage")
            self.imageUrl = nil
            self.analyseButton.setLoading(false)
            self.analyseButton.isEnabled = true
            self.coordinator?.showDetails(tweet)
        }
    }
    
    fileprivate func handleButtonsState() {
        if imageUrl != nil {
            selectPhotoButton.setTitle("Change Photo", for: .normal)
            analyseButton.isHidden = false
            analyseProButton.isHidden = false
        }
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        imagePickerWorker.start()
    }
    
    @IBAction func didTapSelectAnalyseButton(_ sender: Any) {
        guard let imageUrl = imageUrl else {
            return viewModel.failureHandler(self, error: AnalyseError.notImage)
        }
        
        do {
            self.analyseButton.setLoading(true)
            self.analyseButton.isEnabled = false
            try startAnalyse(url: imageUrl)
            
        } catch {
            analyseButton.setLoading(false)
            analyseButton.isEnabled = true
            viewModel.failureHandler(self, error: error)
        }
        
    }
    
    
    fileprivate func startAnalyse(url: URL) throws {
        // Get results from image
        let results = try imageReader.perform(on: url, recognitionLevel: .fast)
        // Identify results to text, username, screenName.
        let query = try imageReader.createQuery(text: results)
        // Handle query in view Model
        let queryText = viewModel.handleQueryResults(query)
        // Search with queryText
        SwifterService.shared.searchTweet(query: queryText, presentFrom: self) { tweets in
            if let tweets = tweets {
                if tweets.count == 0 {
                    self.analyseButton.setLoading(false)
                    self.analyseButton.isEnabled = true
                    self.viewModel.failureHandler(self, error: AnalyseError.notFound)
                }
                self.viewModel.saveTweets(tweets: tweets)
            }
        }
    }
}
