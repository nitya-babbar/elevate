//
//  TabBarViewController.swift
//  Elevate
//
//  Created by Nithya Arun on 4/2/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
        addViewControllers()
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

// MARK: - private functions
fileprivate extension TabBarViewController {
    
    func configureTab() {
        tabBar.tintColor = UIColor.black
        tabBar.isOpaque = true
        tabBar.barTintColor = UIColor.white
        delegate = self
    }

    func addViewControllers() {
        
        viewControllers = [goalViewController(), copingViewController(), goalViewController()]
        
    }
    
    func goalViewController() -> UIViewController {
        let goalsViewController = GoalsViewController()
        let goalsNavigation = UINavigationController(rootViewController: goalsViewController)
        goalsViewController.tabBarItem?.title = NSLocalizedString("Goals", comment: "")
        goalsViewController.tabBarItem?.image = UIImage(systemName: "sun.max")
        goalsViewController.tabBarItem?.selectedImage = UIImage(systemName: "sun.max.fill")
        return goalsNavigation
    }
    
    func copingViewController() -> UIViewController {
        let copingViewController = MeditationViewController()
        let copingNavigation = UINavigationController(rootViewController: copingViewController)
        copingViewController.tabBarItem?.title = NSLocalizedString("Coping", comment: "")
        copingViewController.tabBarItem?.image = UIImage(systemName: "heart")
        copingViewController.tabBarItem?.selectedImage = UIImage(systemName: "heart.fill")
        return copingNavigation
    }
}
