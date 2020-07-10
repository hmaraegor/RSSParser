//
//  PresentService.swift
//  RSSParser
//
//  Created by Egor on 09/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class Presenter {
    
    func presentNewsController(with theNews: News, completionHandler:
    @escaping (UIBarButtonItem, UIViewController) -> ()) {
        let storyboard: UIStoryboard = UIStoryboard(name: Constant.IB.News.storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constant.IB.News.viewControllerID)
        (vc as? NewsViewController)?.news = theNews
        
        let backItem = UIBarButtonItem()
        backItem.title = Constant.NavigationItem.backBarItem
        completionHandler(backItem, vc)
    }
    
}
