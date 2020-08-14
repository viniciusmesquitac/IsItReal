//
//  HistoryListViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class HistoryListViewController: UITableViewController {

    let viewModel = ListTweetViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewModel()
        viewModel.getTweets()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 132
        tableView.register(UINib(nibName: HistoryTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.cellId)
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadViewIfNeeded() {
        
        for cell in tableView.visibleCells {
            cell.setNeedsUpdateConstraints()
        }
        
    }
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        self.loadViewIfNeeded()
    }
    
    @IBAction func startDeleteTweets(_ sender: Any) {
        
        if let selectedRows = tableView.indexPathsForSelectedRows {
            viewModel.handleSelectedTweets(at: selectedRows)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellId) as? HistoryTableViewCell
        if let cellVM = viewModel.cellViewModel(at: indexPath.row) {
            cell?.configure(viewModel: cellVM)
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else { return }
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "TweetDetails") as? TweetDetailsViewController {
            self.navigationController?.present(viewController, animated: true, completion: nil)
        }
    }

}
