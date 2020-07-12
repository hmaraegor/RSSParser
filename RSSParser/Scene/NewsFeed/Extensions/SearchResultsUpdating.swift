//
//  SearchResultsUpdatingExtension.swift
//  RSSParser
//
//  Created by Egor on 11/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

extension NewsFeedController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        dataProvider.dataManager.filterContent(for: searchController.searchBar.text!)
        tableView.reloadData()
    }
    
    func searchControllerSetup() {
        dataProvider.dataManager.searchController.obscuresBackgroundDuringPresentation = false
        dataProvider.dataManager.searchController.searchBar.placeholder = Constant.Placeholder.searchController
        dataProvider.dataManager.searchController.searchResultsUpdater = self
        navigationItem.searchController = dataProvider.dataManager.searchController
    }

}
