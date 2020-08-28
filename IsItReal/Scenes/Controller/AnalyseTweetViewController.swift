//
//  AnallyseTweetViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class AnalyseTweetViewController: UIViewController {
    
    let imageReader = ImageReader()
    let imagePickerWorker = ImagePickerWorker()
    let viewModel = AnalysesTweetViewModel()
    var coordinator: AnalyseTweetCoordinator?
    
    @IBOutlet weak var rootView: AnalyseView!
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.handleButtonsState()
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
            self.rootView.setImage(image: image, url: url)
        }
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleSavedTweet = { tweet in
            self.rootView.removeImage()
            self.rootView.setLoadingAnalyseButton(false)
            self.coordinator?.showDetails(tweet)
        }
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        imagePickerWorker.start()
    }
    
    @IBAction func didTapSelectAnalyseButton(_ sender: Any) {
        guard let imageUrl = rootView.imageUrl else {
            return viewModel.failureHandler(self, error: AnalyseError.notImage)
        }
        do {
            rootView.setLoadingAnalyseButton(true)
            try startAnalyse(url: imageUrl)
        } catch {
            rootView.setLoadingAnalyseButton(false)
            viewModel.failureHandler(self, error: error)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           super.viewWillTransition(to: size, with: coordinator)
            rootView.handlePortraidImage()
       }
    
    fileprivate func startAnalyse(url: URL) throws {
        // Get results from image
        let results = try imageReader.perform(on: url, recognitionLevel: .fast)
        // Identify results to text, username, screenName.
        let query = try imageReader.createQuery(text: results)
        // Handle query in view Model
        let queryText = viewModel.handleQueryResults(query)
        
        // Search with queryText
        if UserDefaultsManager.getAuthToken() != nil {
            SwifterService.shared.search(query: queryText) { tweets in
                if let tweets = tweets {
                    if tweets.isEmpty {
                        self.rootView.setLoadingAnalyseButton(false)
                        SwifterService.shared.getLatest(screenName: query.user!) { (tweets) in
                            if let latestTweets = tweets {
                                if latestTweets.isEmpty {
                                    self.viewModel.failureHandler(self, error: AnalyseError.notFound)
                                }
                                self.coordinator?.showLatests(latestTweets)
                            }
                        }
                    }
                    self.viewModel.saveTweet(tweets: tweets, username: query.user!)
                }
            }
        }
        else {
            SwifterService.shared.searchTweet(query: queryText, presentFrom: self) { tweets in
                if let tweets = tweets {
                    if tweets.isEmpty {
                        self.rootView.setLoadingAnalyseButton(false)
                        self.viewModel.failureHandler(self, error: AnalyseError.notFound)
                    }
                    self.viewModel.saveTweet(tweets: tweets, username: query.user!)
                }
            }
        }
    }
    
}
