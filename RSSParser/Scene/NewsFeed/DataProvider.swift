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

// MARK: - Table view data source

extension DataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getNewsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.IB.NewsFeedCell.cellID, for: indexPath) as? NewsFeedCell else {
            return UITableViewCell()
        }
        
        let news = dataManager.getNews(for: indexPath.row)
        cell.configure(with: news)
        
        return cell
    }
    
}

// MARK: - Table view delegate

extension DataProvider: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notes = dataManager.getFeed()
        PresentService().presentNewsController(with: notes[indexPath.row]) { (backItem, vc) in
            self.vc.navigationItem.backBarButtonItem = backItem
            self.vc.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
