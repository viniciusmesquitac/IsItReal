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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        self.switchUserPhoto()
    }
    
    @IBAction func didTapSelectAnalyseButton(_ sender: Any) {
        // Call Framework Vision or SwiftOCR to extract text [OK]
        if let url = imageUrl {
            let results = imageReader.perform(on: url, recognitionLevel: .fast)
            // Identify results to text, username, screenName.
            guard let query = imageReader.createQuery(text: results).query else { return }
             // Get Results from Vision and search with Twitter API.
            SwifterService.shared.searchTweet(query: query, presentFrom: self) { (tweets) in
                // Handle tweet result.
                print(tweets?.first?.text ?? "nil")
            }
        }
    }
}

extension AnalyseTweetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func switchUserPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageUrl = info[.imageURL] as? URL
        guard let image = info[.editedImage] as? UIImage else { return }
        imageToAnalyse.image = image
        dismiss(animated: true)
    }
}
