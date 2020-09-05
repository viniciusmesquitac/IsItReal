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
        setupImageAnalyser()
        updateViewModel()
    }
    
    fileprivate func setupImageAnalyser() {
        imageAnalyser.delagate = self
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
            return viewModel.failureHandler(self, error: ImageAnalyserError.notImage)
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

extension AnalyseTweetViewController: ImageAnalyserDelegate {
    
    func setLoading(_ state: Bool) {
        rootView.setLoadingAnalyseButton(state)
    }
    
    func handleError(_ error: Error) {
        viewModel.failureHandler(self, error: error)
    }
    
    func handleLatestTweets(_ tweets: [Tweet]?) {
        guard let tweets = tweets else { return }
        if tweets.isEmpty {
            viewModel.failureHandler(self, error: ImageAnalyserError.notFound)
        }
        coordinator?.showLatests(tweets)
        rootView.setLoadingAnalyseButton(false)
    }
    
}
