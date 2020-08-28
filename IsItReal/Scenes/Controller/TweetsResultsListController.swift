//
//  TweetsResultsListController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 28/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class TweetsResultsListController: UITableViewController {
    
    var tweets: [TweetDetailsViewModel]?
    let viewModel = ListTweetViewModel()
    
    override func viewDidLoad() {
        updateViewModel()
        if let tweets = tweets {
            viewModel.tweetsDetailsViewModel = tweets
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: CustomCell.nibName, bundle: nil),
                           forCellReuseIdentifier: CustomCell.cellId)
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId) as? CustomCell
        if let cellVM = viewModel.cellViewModel(at: indexPath.row) {
            cell?.configure(viewModel: cellVM)
        }
        return cell ?? UITableViewCell()
    }
    
}
