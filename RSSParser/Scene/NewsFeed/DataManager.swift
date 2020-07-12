//
//  DataManager.swift
//  RSSParser
//
//  Created by Egor on 12/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class DataManager {
    
    var newsArray: [News] = []
    var filteredNews: [News] = []
    var isFiltiring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
}
