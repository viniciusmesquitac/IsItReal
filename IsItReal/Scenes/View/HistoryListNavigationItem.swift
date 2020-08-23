//
//  HistoryListView.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 23/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
class HistoryListNavigationItem: UINavigationItem {
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    func handleBarButtonState(_ tableView: UITableView) {
        if tableView.isEditing {
            editButton.title = "Done"
            deleteButton.isEnabled = true
            deleteButton.tintColor = nil
        } else {
            editButton.title = "Edit"
            deleteButton.isEnabled = false
            deleteButton.tintColor = .clear
        }
    }
    
    func switchStateDeleteButton() {
        deleteButton.isEnabled = !deleteButton.isEnabled
    }
}
