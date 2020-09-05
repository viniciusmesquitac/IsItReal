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
    func didSelectImage(image: UIImage, imageUrl: URL?)
}

class ImagePickerWorker: NSObject {
    
    private let picker = UIImagePickerController()
    weak var delegate: ImagePickerDelegate?
    
    func start() {
        switchUserPhoto()
    }
    
}

extension ImagePickerWorker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func switchUserPhoto() {
        picker.delegate = self
        picker.allowsEditing = true
        delegate?.present(viewController: picker)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageUrl = info[.imageURL] as? URL
        guard let image = info[.editedImage] as? UIImage else { return }
        delegate?.didSelectImage(image: image, imageUrl: imageUrl)
        picker.dismiss(animated: true, completion: nil)
//            let cropViewController = UIStoryboard.instantiateCropImage()
//            cropViewController.image = image
//            cropViewController.imageUrl = imageUrl
//            self.delegate?.present(viewController: cropViewController)
    }
    
}
