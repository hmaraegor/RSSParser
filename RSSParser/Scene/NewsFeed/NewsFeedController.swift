//
//  NewsFeedController.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    private var rss: RSS?
    private var newsArray: [News] = []
    private var filteredNews: [News] = []
    private var indicator: ProgressIndicator?
    private let searchController = UISearchController(searchResultsController: nil)
    private var myRefreshControl: UIRefreshControl = {
        let spinner = UIRefreshControl()
        let title = NSLocalizedString("Обновление ленты", comment: "Потянуть для обновления")
        spinner.attributedTitle = NSAttributedString(string: title)
        spinner.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return spinner
    }()
    private var newsReceived: Bool = false
    
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltiring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    @objc private func refresh(sender: UIRefreshControl) {
        fetchNewsFeed(refreshControl: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        //self.navigationController!.navigationBar.isTranslucent = false
        
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        self.title = "vesti.ru"
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: Constants.Color().vcTitle]
        self.tableView.addSubview(myRefreshControl)
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.white, msg: "Загрузка ленты")
        self.view.addSubview(indicator!)
        
        searchControllerSetup()
        blockInput()
        
        fetchNewsFeed()
    }
    
    func blockInput(){
        searchController.searchBar.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        indicator!.start()
    }
    
    func unblockInput(){
        self.indicator!.stop()
        self.view.isUserInteractionEnabled = true
        self.searchController.searchBar.isUserInteractionEnabled = true
    }
    
    private func searchControllerSetup() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по категориям"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func fetchNewsFeed(refreshControl: UIRefreshControl? = nil){
        
        NewsFeedService().gistListRequest() { (array, error) in
            if array != nil {
                self.rss = array!
                self.newsArray = self.rss?.channel.item ?? []
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkErrorService, viewController: self)
                }
            }
            DispatchQueue.main.async {
                self.unblockInput()
                
                self.newsReceived = true
                
                self.tableView.reloadData()
                guard let refreshControl = refreshControl else { return }
                refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltiring {
            return filteredNews.count
        }
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsFeedCell else {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notes: [News]
        if isFiltiring {
            notes = filteredNews
        }
        else {
            notes = newsArray
        }
        Presenter().presentNewsController(with: notes[indexPath.row]) { (backItem, vc) in
            self.navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension NewsFeedController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //print("updateSearchResults: ", searchController.searchBar.text!)
        filterContentForSearchText(searchController.searchBar.text!)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("SearchButtonClicked")
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("TextDidBeginEditing") //
        print(self.searchController.searchBar.text)
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

extension NewsFeedController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked: ", searchController.searchBar.text!)
        //searchRequest(term: searchController.searchBar.text!)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("TextDidBeginEditing")
    }
}
