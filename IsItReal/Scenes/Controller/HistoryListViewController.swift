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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var listNavigationItem: HistoryListNavigationItem!
    @IBOutlet weak var emptyState: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.setEditing(false, animated: false)
        searchController.searchBar.isUserInteractionEnabled = true
        self.emptyState.isHidden = true
        _ = viewModel.getTweets()
        self.loadViewIfNeeded()
        listNavigationItem.handleBarButtonState(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewModel()
        configureSearchBar()
        coordinator = HistoryListCordinator(navigationController: navigationController!)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: CustomCell.nibName, bundle: nil),
                           forCellReuseIdentifier: CustomCell.cellId)
    }
    
    fileprivate func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search tweets or users"
        listNavigationItem.searchController = searchController
        listNavigationItem.hidesSearchBarWhenScrolling = true
        // definesPresentationContext = true
    }
    
    fileprivate func updateViewModel() {
        viewModel.handleUpdate = {
            if self.viewModel.numberOfRows == 0 {
                self.emptyState.isHidden = false
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
        searchController.searchBar.isUserInteractionEnabled = !searchController.searchBar.isUserInteractionEnabled
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setNeedsUpdateConstraints()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else { return }
        coordinator?.showDetails(tweet: viewModel.getTweet(for: indexPath.item)!)
    }
}

extension HistoryListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        let allTweets = viewModel.getTweets()
        viewModel.tweetsDetailsViewModel.removeAll(keepingCapacity: false)
        emptyState.isHidden = true
        let filteredTweets = allTweets.filter {
            $0.tweet.user.name.contains(searchText) ||
            $0.tweet.text.contains(searchText)
        }
        viewModel.tweetsDetailsViewModel = filteredTweets
        
        if searchText.isEmpty {
            viewModel.tweetsDetailsViewModel = allTweets
        }
    }
    
}
