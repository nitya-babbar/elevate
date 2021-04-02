//
//  ElevateTabBarController.swift
//  Elevate
//
//  Created by Rhonny Gonzalez on 4/2/21.
//

import UIKit

class ElevateTabBarViewController: UITabBarController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
        addViewControllers()
    }

}

extension ElevateTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

// MARK: - private functions
fileprivate extension ElevateTabBarViewController {
    
    func configureTab() {
        tabBar.tintColor = UIColor.black
        tabBar.isOpaque = true
        tabBar.barTintColor = UIColor.white
        delegate = self
    }

    func addViewControllers() {
        
        viewControllers = [goalViewController(), goalViewController(), goalViewController()]
        
    }
    
    func goalViewController() -> UIViewController {
        let goalsViewController = GoalsViewController()
        let goalsNavigation = UINavigationController(rootViewController: goalsViewController)
        goalsViewController.tabBarItem?.title = NSLocalizedString("Goals", comment: "")
        goalsViewController.tabBarItem?.image = UIImage(systemName: "sun.max")
        goalsViewController.tabBarItem?.selectedImage = UIImage(systemName: "sun.max.fill")
        return goalsNavigation
    }
    
}
