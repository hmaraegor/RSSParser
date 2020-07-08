//
//  ImageDownloader.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    private init() { }
    
    static func downloadImage(stringURL: String, completionHandler:
        @escaping (Data) -> ()) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            completionHandler(imageData)
        }
    }
}
