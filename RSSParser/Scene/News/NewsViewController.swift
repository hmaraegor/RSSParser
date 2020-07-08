//
//  NewsViewController.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var news: News?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = news?.category {
            self.title = news?.category
        }
        
        titleLabel.text = news?.title
        textView.text = news?.fullText
        titleLabel.numberOfLines = 0
        
        guard let imageUrl = news?.enclosure?.first?.url else { imageView.isHidden = true
            return
        }
        
        ImageDownloader.downloadImage(stringURL: imageUrl) { (imageData) in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
