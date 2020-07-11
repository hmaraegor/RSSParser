//
//  MyRefreshControl.swift
//  RSSParser
//
//  Created by Egor on 11/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class MyRefreshControl: UIRefreshControl {
    
    var function: (_ refreshControl: UIRefreshControl? ) -> ()
    
    init(function: @escaping (UIRefreshControl?) -> ()) {
        self.function = function
        super.init()
        let title = NSLocalizedString(Constant.IndicatorText.RefreshControlKey, comment: Constant.IndicatorText.RefreshControlComment)
        self.attributedTitle = NSAttributedString(string: title)
        self.addTarget(nil, action: #selector(refresh), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        function(sender)
    }
}
