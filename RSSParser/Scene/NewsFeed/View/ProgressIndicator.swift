//
//  ProgressIndicator.swift
//  RSSParser
//
//  Created by Egor on 08/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import Foundation
class ProgressIndicator: UIView {
    
    var indicatorColor:UIColor
    var loadingViewColor:UIColor
    var loadingMessage:String
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    init(inview:UIView, loadingViewColor:UIColor, indicatorColor:UIColor, msg:String){
        
        self.indicatorColor = indicatorColor
        self.loadingViewColor = loadingViewColor
        self.loadingMessage = msg
        super.init(frame: CGRect(x: inview.frame.midX - 90, y: inview.frame.midY - 250 , width: 180, height: 50))
        initalizeCustomIndicator()
        
    }
    
    convenience init(inview:UIView) {
        self.init(inview: inview, loadingViewColor: UIColor.gray, indicatorColor: UIColor.white, msg: Constant.IndicatorText.progresIndicator)
    }
    
    convenience init(inview:UIView,messsage:String) {
        self.init(inview: inview, loadingViewColor: UIColor.brown, indicatorColor:UIColor.black, msg: messsage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalizeCustomIndicator(){
        
        messageFrame.frame = self.bounds
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.tintColor = indicatorColor
        activityIndicator.color = indicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: self.bounds.origin.x + 6, y: 0, width: 20, height: 50)
        //print(activityIndicator.frame)
        let strLabel = UILabel(frame:CGRect(x: self.bounds.origin.x + 30, y: 0, width: self.bounds.width - (self.bounds.origin.x + 30) , height: 50))
        strLabel.text = loadingMessage
        strLabel.adjustsFontSizeToFitWidth = true
        strLabel.textColor = UIColor.white
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = loadingViewColor
        messageFrame.alpha = 1.0
        messageFrame.addSubview(activityIndicator)
        messageFrame.addSubview(strLabel)
        
    }
    
    func  start(){
        if !self.subviews.contains(messageFrame){
            activityIndicator.startAnimating()
            self.addSubview(messageFrame)
        }
    }
    
    func stop(){
        if self.subviews.contains(messageFrame){
            activityIndicator.stopAnimating()
            messageFrame.removeFromSuperview()
        }
    }
}
