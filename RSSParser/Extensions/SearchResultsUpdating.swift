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
        filterContentForSearchText(searchController.searchBar.text!)
        tableView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredNews = newsArray.filter() { (news: News) -> Bool in
            if news.category != nil {
                return (news.category!.lowercased().contains(searchText.lowercased()))
            }
            return false
        }
    }
}
