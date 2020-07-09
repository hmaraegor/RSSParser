//
//  NewsFeedController.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import XMLParsing

let xmlStr = """
            <?xml version="1.0" encoding="UTF-8"?>
            <note>
                <to>Bob</to>
                <from>Jane</from>
                <heading>Reminder</heading>
                <body>Second element body</body>
                <new firstAtr="frstArt" secondAtr="scndAtr"/>
            </note>
            """

//let xmlVesti = """
//               <?xml version="1.0" encoding="UTF-8"?>
//               <rss
//                   xmlns:yandex="http://news.yandex.ru"
//                   xmlns:media="http://search.yahoo.com/mrss/"
//                   version="2.0">
//                <channel>
//                   <title>Вести.Ru</title>
//                   <about>https://www.vesti.ru/</about>
//                   <description>Сетевое издание. Новости, видео и фото дня</description>
//                   <link>https://www.vesti.ru/</link>
//                   <item>
//                     <title>В Москве откроется бесплатный автокинотеатр</title>
//                     <link>https://www.vesti.ru/doc.html?id=3279001</link>
//                     <amplink>https://amp.vesti.ru/doc.html?id=3279001</amplink>
//                     <description>В столице в рамках празднования Дня московского транспорта откроется бесплатный автокинотеатр. Сеансы будут проходить на перехватывающей парковке возле станции метро &quot;Филатов Луг&quot; на юго-западе столицы.</description>
//                     <pubDate>Tue, 07 Jul 2020 09:17:00 +0300</pubDate>
//                     <category>Общество</category>
//                     <enclosure url="https://cdn-st3.rtr-vesti.ru/p/xw_1820030.jpg" type="image/jpeg" width="720" height="409" />
//                     <yandex:full-text>В столице в рамках празднования Дня московского транспорта откроется бесплатный автокинотеатр.
//
//                        Как сообщает сайт mos.ru, сеансы будут проходить на перехватывающей парковке возле станции метро &quot;Филатов Луг&quot; на юго-западе столицы. Показы рассчитаны на 100 машин.
//
//                        Зрителям увидят &quot;Сладкую жизнь&quot; Федерико Феллини и &quot;Джентльменов&quot; Гая Ричи, а также картины международного кинофестиваля Beat Film Festival. Всего с июля по октябрь планируется показать 17 фильмов.
//
//                        Первый показ состоится 18 июля. Регистрация откроется 12 июля в 00:00 на сайте проекта.</yandex:full-text>
//                   </item>
//                   </channel>
//               </rss>
//               """

struct Note: Codable {
    var to: String
    var from: String
    var heading: String
    var body: String
    var new: [New]?
}

struct New: Codable {
    var firstAtr: String?
    var secondAtr: String?
}

func example(){
    guard let data = xmlStr.data(using: .utf8) else { return }

    let note = try? XMLDecoder().decode(Note.self, from: data)

    print(note)
}




class NewsFeedController: UITableViewController {
    
    var rss: RSS?
    var newsArray: [News] = []
    //0//let loadSpinner = UIActivityIndicatorView(style: .gray)
    //1//var activityIndicatorView: ActivityIndicatorView!
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
        
        //0//loadSpinner.startAnimating()
        //0//tableView.backgroundView = loadSpinner
        
        //1//self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
        //1//self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        indicator = ProgressIndicator(inview:self.view,loadingViewColor: UIColor.gray, indicatorColor: UIColor.white, msg: "Загрузка ленты")
        self.view.addSubview(indicator!)
        indicator!.start()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //example()
        
        fetchNewsFeed()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        fetchNewsFeed(refreshControl: sender)
    }
    
    func fetchNewsFeed(refreshControl: UIRefreshControl? = nil){
        
        //1//self.activityIndicatorView.startAnimating()
        //1//UIApplication.shared.beginIgnoringInteractionEvents()
        
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
                //1//self.activityIndicatorView.stopAnimating()
                self.indicator!.stop()
                UIApplication.shared.endIgnoringInteractionEvents()
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
