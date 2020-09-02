//
//  AnallyseTweetViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class AnalyseTweetViewController: UIViewController {
    
    let imageAnalyser = ImageAnalyser()
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
        handleImageAnalyser()
        updateViewModel()
    }
    
    fileprivate func handleImageAnalyser() {
        imageAnalyser.handleFromLatestTweets = { tweets in
            guard let tweets = tweets else { return }
            if tweets.isEmpty {
                self.viewModel.failureHandler(self, error: AnalyseError.notFound)
            }
            self.coordinator?.showLatests(tweets)
            self.rootView.setLoadingAnalyseButton(false)
        }
        imageAnalyser.notFindImageError = {
            self.viewModel.failureHandler(self, error: AnalyseError.notFound)
        }
        imageAnalyser.stopLoading = {
            self.rootView.setLoadingAnalyseButton(false)
        }
        imageAnalyser.startLoading = {
            self.rootView.setLoadingAnalyseButton(true)
        }

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
            try imageAnalyser.start(imageUrl: imageUrl, completion: { tweet in
                _ = self.viewModel.saveTweet(tweet, image: self.rootView.imageUrl)
            })
        } catch {
            rootView.setLoadingAnalyseButton(false)
            viewModel.failureHandler(self, error: error)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rootView.handlePortraidImage()
    }
    
}
