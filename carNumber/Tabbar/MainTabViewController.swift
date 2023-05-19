//
//  MainTabViewController.swift
//  HomeCamApp
//
//  Created by 박경춘 on 2023/04/21.
//

import Foundation
import UIKit


class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabView()
    }
    
    
    func initTabView() {
        
        let tabBarViewController: [UIViewController] = TabBarItem.allCases.map { tabCase in
            let viewController = tabCase.viewController
            viewController.tabBarItem = UITabBarItem(
                title: tabCase.title,
                image: tabCase.icon.default,
                selectedImage: tabCase.icon.selected)
            
            return viewController
        }
        
        self.viewControllers = tabBarViewController
        
        
        
        
    }

}
