//
//  ImagePickerWorker.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit


protocol ImagePickerDelegate: class {
    func present(viewController: UIViewController)
}

class ImagePickerWorker: NSObject {
    var didSelectImage: ((UIImage, URL?) -> Void)?
    let picker = UIImagePickerController()
    weak var delegate: ImagePickerDelegate?
    
    func start() {
        switchUserPhoto()
    }
    
}

extension ImagePickerWorker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func switchUserPhoto() {
        picker.allowsEditing = true
        picker.delegate = self
        delegate?.present(viewController: picker)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageUrl = info[.imageURL] as? URL
        guard let image = info[.editedImage] as? UIImage else { return }
        didSelectImage?(image, imageUrl)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension AnalyseTweetViewController: ImagePickerDelegate {
    func present(viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}
