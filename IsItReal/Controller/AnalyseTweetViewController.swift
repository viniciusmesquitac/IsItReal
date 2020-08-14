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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSelectPhotoButton(_ sender: Any) {
        self.switchUserPhoto()

    }
    
    @IBAction func didTapSelectAnalyseButton(_ sender: Any) {
        // TODO: Call Framework Vision or SwiftOCR to extract text [OK]
        let imageReader = ImageReader()
        if let url = imageUrl {
            let results = imageReader.perform(on: url, recognitionLevel: .fast)
            // Identify results to text, username, screenName.
            print(results)
            
            // TODO: Get Results from Vision and search with Twitter API.
            SwifterService.shared.searchTweet(query: "Presidente Jair Bolsonaro. Desejo-lhe sucesso.", presentFrom: self) { (tweet) in
                print(tweet?.count)
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
