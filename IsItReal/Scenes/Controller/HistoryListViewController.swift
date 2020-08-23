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
    var coordinator: HistoryListCordinator?
    
    @IBOutlet weak var listNavigationItem: HistoryListNavigationItem!
    @IBOutlet weak var emptyState: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.setEditing(false, animated: false)
        _ = viewModel.getTweets()
        listNavigationItem.handleBarButtonState(tableView)
        loadViewIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewModel()
        coordinator = HistoryListCordinator(navigationController: navigationController!)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: CustomCell.nibName, bundle: nil),
                           forCellReuseIdentifier: CustomCell.cellId)
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleUpdate = {
            self.emptyState.isHidden = false
            if self.viewModel.numberOfRows != 0 {
                self.emptyState.isHidden = true
            }
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
        listNavigationItem.switchStateDeleteButton()
        listNavigationItem.handleBarButtonState(tableView)
        self.loadViewIfNeeded()
    }
    
    @IBAction func startDeleteTweets(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            viewModel.handleSelectedTweets(at: selectedRows)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .right)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId) as? CustomCell
        if let cellVM = viewModel.cellViewModel(at: indexPath.row) {
            cell?.configure(viewModel: cellVM)
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else { return }
        coordinator?.showDetails(tweet: viewModel.getTweet(for: indexPath.item)!)
    }

}
