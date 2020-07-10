//
//  AppConstants.swift
//  RSSParser
//
//  Created by Egor on 09/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

struct Constant {
    
    struct Color {
        static let vcTitleGray = UIColor.init(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1.0)
    }
    
    struct URL {
        static let rssVestiRu = "https://www.vesti.ru/vesti.rss"
    }
    
    struct NavigationItem {
        static let backBarItem = "Назад"
    }
    
    struct Title {
        static let prefixCategory = "Категория: "
        static let sourceWebSite = "vesti.ru"
    }
    
    struct Indicator {
        static let text = "Загрузка ленты"
    }

    struct Placeholder {
           static let searchController = "Поиск по категориям"
    }
    
    struct IB {
        struct NewsFeed {
            static let storyboardName = "NewsFeed"
            static let viewControllerID = "NewsFeedVC"
        }
        
        struct News {
            static let storyboardName = "News"
            static let viewControllerID = "NewsVC"
        }
        
        struct NewsFeedCell {
            static let xibName = "NewsFeedCell"
            static let cellID = "Cell"
        }
    }
    
}
