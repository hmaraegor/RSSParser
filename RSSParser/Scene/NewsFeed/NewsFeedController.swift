//
//  NewsFeedController.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    var rss: RSS?
    var newsArray: [News] = []
    var indicator:ProgressIndicator?
    
    let myRefreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Загрузка новостей", comment: "Потянуть для обновления")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "vesti.ru"
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        self.refreshControl = myRefreshControl
        
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.white, msg: "Загрузка ленты")
        self.view.addSubview(indicator!)
        self.view.isUserInteractionEnabled = false
        indicator!.start()
        
        fetchNewsFeed()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        fetchNewsFeed(refreshControl: sender)
    }
    
    func fetchNewsFeed(refreshControl: UIRefreshControl? = nil){
        
        NewsFeedService().gistListRequest() { (array, error) in
            if array != nil {
                self.rss = array!
                self.newsArray = self.rss?.channel.item ?? []
                print("newsArray news feed \n", self.newsArray)
            }
            else if error != nil {
                DispatchQueue.main.async {
                    ErrorAlertService.showErrorAlert(error: error as! NetworkErrorService, viewController: self)
                }
            }
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                self.indicator!.stop()
                self.tableView.reloadData()
                guard let refreshControl = refreshControl else { return }
                refreshControl.endRefreshing()
            }
        }
    }
    
    
    func presentNewsController(with theNews: News) {
        let storyboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsVC")
        (vc as? NewsViewController)?.news = theNews
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsFeedCell else {
            return UITableViewCell()
        }
        
        let news = newsArray[indexPath.row]
        cell.configure(with: news)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentNewsController(with: newsArray[indexPath.row])
    }

}
