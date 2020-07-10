//
//  SceneDelegate.swift
//  RSSParser
//
//  Created by Egor on 07/07/2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: Constant.IB.NewsFeed.storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constant.IB.NewsFeed.viewControllerID)
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        return
    }

}

