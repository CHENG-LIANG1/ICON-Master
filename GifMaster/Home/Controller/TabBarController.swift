//
//  ViewController.swift
//  GifMaster
//
//  Created by 梁程 on 2021/7/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)

    fileprivate func createNavController(for rootViewController: UIViewController,
                                                 
                                                    image: UIImage, selected: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selected
        navController.navigationBar.prefersLargeTitles = true
        return navController
      }
    
    func setupVCs() {
          viewControllers = [
            createNavController(for: HomeViewController(), image: UIImage(systemName: "house")!.withConfiguration(imageConfig), selected: (UIImage(systemName: "house.fill")?.withConfiguration(imageConfig).withTintColor(.orange, renderingMode: .alwaysOriginal))!),
            createNavController(for: SearchViewController(), image: UIImage(systemName: "magnifyingglass")!.withConfiguration(imageConfig), selected: (UIImage(systemName: "magnifyingglass")?.withConfiguration(imageConfig).withTintColor(.orange, renderingMode: .alwaysOriginal))!),
            createNavController(for: SettingsViewController(), image: UIImage(systemName: "gearshape")!.withConfiguration(imageConfig), selected: (UIImage(systemName: "gearshape.fill")?.withConfiguration(imageConfig).withTintColor(.orange, renderingMode: .alwaysOriginal))!)
          ]
      }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.clipsToBounds = true
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
      
        
        
        
        let selectedColor = UIColor.systemOrange
        
        self.tabBar.unselectedItemTintColor = .black

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        

        setupVCs()
        self.tabBar.items![1].title = "Search"
        self.tabBar.items![2].title = "Settings"
        

    }


}

