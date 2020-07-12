//
//  DataProvider.swift
//  RSSParser
//
//  Created by Egor on 12/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    
    override init() {
            super.init()
    }
    
    var dataManager = DataManager()
    var vc = UIViewController()
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
}

extension DataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataManager.isFiltiring {
            return dataManager.filteredNews.count
        }
        return dataManager.newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.IB.NewsFeedCell.cellID, for: indexPath) as? NewsFeedCell else {
            return UITableViewCell()
        }
        
        let news: News
        if dataManager.isFiltiring {
            news = dataManager.filteredNews[indexPath.row]
        }
        else {
            news = dataManager.newsArray[indexPath.row]
        }
        
        cell.configure(with: news)
        
        return cell
    }
    
}

extension DataProvider: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notes: [News]
        if dataManager.isFiltiring {
            notes = dataManager.filteredNews
        }
        else {
            notes = dataManager.newsArray
        }
        PresentService().presentNewsController(with: notes[indexPath.row]) { (backItem, vc) in
            
            self.vc.navigationItem.backBarButtonItem = backItem
            self.vc.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
