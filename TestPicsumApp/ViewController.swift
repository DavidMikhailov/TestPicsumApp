//
//  ViewController.swift
//  TestPicsumApp
//
//  Created by Давид Михайлов on 23.12.2020.
//  Copyright © 2020 Давид Михайлов. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }
    
    func createTabBar () {
        
        let randomVC = UINavigationController(rootViewController: RandomViewController())
        randomVC.title = "Random"
        randomVC.tabBarItem.image = UIImage(systemName: "photo")
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem.image = UIImage(systemName: "star.fill")
        
        setViewControllers([randomVC, favoritesVC], animated: false)
        modalPresentationStyle = .fullScreen
    }
    
}




