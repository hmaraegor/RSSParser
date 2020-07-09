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
    
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var stackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = news?.category {
            self.title = news?.category
        }
        
        titleLabel.text = news?.title
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        textLabel.text = news?.fullText
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        
        
        let constraintHeight = imageView.frame.height + titleLabel.frame.height + textLabel.frame.height
        stackViewHeightConstraint.constant = constraintHeight
        
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
