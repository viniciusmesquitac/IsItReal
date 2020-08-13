//
//  HistoryListViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

private var cellId = "tweetHistoryCell"

class HistoryListViewController: UITableViewController {

    let listTweetViewModel = ListTweetViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewModel()
        navigationItem.title = "History"
        navigationController?.navigationItem.setRightBarButton(UIBarButtonItem(), animated: false)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func updateViewModel() {
        listTweetViewModel.handleUpdate = {
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
        return listTweetViewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? HistoryTableViewCell
        if let cellVM = listTweetViewModel.cellViewModel(at: indexPath.row) {
            cell?.configure(viewModel: cellVM)
        }
        return cell ?? UITableViewCell()
    }

}
