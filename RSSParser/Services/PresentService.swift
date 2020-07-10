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
        let storyboard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewsVC")
        (vc as? NewsViewController)?.news = theNews
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
//        navigationItem.backBarButtonItem = backItem
//        navigationController?.pushViewController(vc, animated: true)
        completionHandler(backItem, vc)
    }
    
}
