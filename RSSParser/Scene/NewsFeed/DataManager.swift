//
//  DataManager.swift
//  RSSParser
//
//  Created by Egor on 12/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class DataManager {
    
    private var rss: RSS?
    private var newsArray: [News] = []
    private var filteredNews: [News] = []
    private var isFiltiring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    func getNews(for index: Int) -> News {
        if isFiltiring {
            return filteredNews[index]
        }
        else {
            return newsArray[index]
        }
    }
    
    func getFeed() -> [News] {
        if isFiltiring {
             return filteredNews
        }
        else {
            return newsArray
        }
    }
    
    func getNewsCount() -> Int {
        if isFiltiring {
            return filteredNews.count
        }
        return newsArray.count
    }
    
    func filterContent(for searchText: String) {
        filteredNews = newsArray.filter() { (news: News) -> Bool in
            if news.category != nil {
                return (news.category!.lowercased().contains(searchText.lowercased()))
            }
            return false
        }
    }
    
    func addRss(array: RSS!) {
        rss = array!
    }
    
    func addNewsArray() {
        newsArray = rss?.channel.item ?? []
    }
    
}
