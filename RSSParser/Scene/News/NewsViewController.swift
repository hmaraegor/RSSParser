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
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var stackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
        if let category = news?.category {
            self.title = Constant.Title.prefixCategory + category
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: Constant.Color.vcTitleGray]
        }
        
        titleLabel.text = news?.title
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        textLabel.text = news?.fullText
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        
        let constraintHeight = titleLabel.frame.height + textLabel.frame.height + 40
        stackViewHeightConstraint.constant = constraintHeight
        
        guard let imageUrl = news?.enclosure?.first?.url else {
            stackViewHeightConstraint.constant = constraintHeight
            imageView.isHidden = true
            return
        }
        
        activityIndicator.startAnimating()
        stackViewHeightConstraint.constant = constraintHeight + imageView.frame.height
        
        ImageDownloader.downloadImage(stringURL: imageUrl) { (imageData) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
