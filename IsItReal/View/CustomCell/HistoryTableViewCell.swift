//
//  HistoryCustomTableViewCell.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    fileprivate var tweetUserName: UILabel {
        let label = UILabel()
        label.text = ""
        return label
    }
    
    fileprivate var tweetUserScreenName: UILabel {
        let label = UILabel()
        label.text = ""
        return label
    }
    
}
