//
//  NewsFeedService.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    func gistListRequest(completionHandler:
    @escaping (RSS?, Error?) -> ()) {
        
        let url = "https://www.vesti.ru/vesti.rss"
        
        NetworkService().getData(url: url) { (result: Result<RSS, NetworkErrorService>) in
            
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
