//
//  NewsFeedCell.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    func configure(with content: News) {
        titleLabel.text = content.title
        dateLabel.text = getDate(strDate: content.pubDate)
        titleLabel.numberOfLines = 0
    }
    
    func getDate(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        let myDate = formatter.date(from: strDate) //as NSDate?
        formatter.dateFormat = "HH:mm d MMM y"
        formatter.locale = Locale(identifier: "ru_Ru")
        let newDate = formatter.string(from: myDate!)
        
        return newDate
    }
    
}
