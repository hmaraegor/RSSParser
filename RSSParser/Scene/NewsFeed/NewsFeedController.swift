//
//  NewsFeedController.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    @IBOutlet var dataProvider: DataProvider!
    
    private var rss: RSS?
    private var indicator: ProgressIndicator?
    private var newsReceived: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.vc = self
        
        let myRefreshControl = MyRefreshControl(function: fetchNewsFeed)
        self.tableView.addSubview(myRefreshControl)
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        let nib = UINib(nibName: Constant.IB.NewsFeedCell.xibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.IB.NewsFeedCell.cellID)
        
        self.title = Constant.Title.sourceWebSite
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: Constant.Color.vcTitleGray]
        indicator = ProgressIndicator(inview: self.view)
        self.view.addSubview(indicator!)
        
        searchControllerSetup()
        blockInput()
        
        fetchNewsFeed()
        
        
    }
    
    func blockInput(){
        dataProvider.dataManager.searchController.searchBar.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        indicator!.start()
    }
    
    func unblockInput(){
        self.indicator!.stop()
        self.view.isUserInteractionEnabled = true
        self.dataProvider.dataManager.searchController.searchBar.isUserInteractionEnabled = true
    }

    private func searchControllerSetup() {
        dataProvider.dataManager.searchController.obscuresBackgroundDuringPresentation = false
        dataProvider.dataManager.searchController.searchBar.placeholder = Constant.Placeholder.searchController
        dataProvider.dataManager.searchController.searchResultsUpdater = self
        navigationItem.searchController = dataProvider.dataManager.searchController
    }
    
     func fetchNewsFeed(refreshControl: UIRefreshControl? = nil){
        
        NewsFeedService().gistListRequest() { (array, error) in
            if array != nil {
                self.rss = array!
                self.dataProvider.dataManager.newsArray = self.rss?.channel.item ?? []
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkErrorService, viewController: self)
                }
            }
            DispatchQueue.main.async {
                if !self.newsReceived {
                    self.newsReceived = true
                    self.unblockInput()
                }
                self.tableView.reloadData()
                guard let refreshControl = refreshControl else { return }
                refreshControl.endRefreshing()
            }
        }
    }

}



