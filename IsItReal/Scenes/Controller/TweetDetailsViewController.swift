//
//  TweetDetailsViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
import SafariServices

class TweetDetailsViewController: UIViewController {
    
    var viewModel: TweetDetailsViewModel?
    @IBOutlet weak var rootView: TweetDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            rootView.configure(viewModel: viewModel)
        }
    }
    
    @IBAction func didSelecShareButton(_ sender: Any) {
        if let sharetext = viewModel?.tweet.text {
            let vc = UIActivityViewController(activityItems: [sharetext], applicationActivities: [])
            vc.popoverPresentationController?.sourceView = self.view
            present(vc, animated: true)
        }
    }
    @IBAction func didSelectCopyButton(_ sender: Any) {
        guard let link = viewModel?.link, let url = URL(string: link) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
