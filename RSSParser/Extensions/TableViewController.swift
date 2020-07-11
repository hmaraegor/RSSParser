//
//  TableViewControllerExtension.swift
//  RSSParser
//
//  Created by Egor on 11/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension NewsFeedController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltiring {
            return filteredNews.count
        }
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.IB.NewsFeedCell.cellID, for: indexPath) as? NewsFeedCell else {
            return UITableViewCell()
        }
        
        let news: News
        if isFiltiring {
            news = filteredNews[indexPath.row]
        }
        else {
            news = newsArray[indexPath.row]
        }
        
        cell.configure(with: news)
        
        return cell
    }
    
    
    
}

// MARK: - UITableViewDelegate

extension NewsFeedController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notes: [News]
        if isFiltiring {
            notes = filteredNews
        }
        else {
            notes = newsArray
        }
        PresentService().presentNewsController(with: notes[indexPath.row]) { (backItem, vc) in
            self.navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
