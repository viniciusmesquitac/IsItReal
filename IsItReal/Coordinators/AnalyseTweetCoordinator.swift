//
//  AnalyseTweetCoordinator.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol AnalyseTweetCoordinatorDelegate: class {
    func alert()
}

final class AnalyseTweetCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard.instantiateAnalyseTweetViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}


/*
 
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
*/
