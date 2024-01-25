//
//  TabBarController.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

enum Controllers : Int, CaseIterable {
    case menu
    case contacts
    case profile
    case bag
}

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        setControllers()
    }

    private func configureTabBar() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inActive
        
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
    
    private func setControllers() {
        
        // Уставнока контроллеров по типу 
        /// let menuController = MenuController()
        /// /// let menuNavigation = NavBarController(rootViewController: menuController)
        /// /// menuNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.menu, image: Resources.Images.TabBar.menu, tag: Controllers.menu.rawValue)
        let controllers : [NavBarController] = Controllers.allCases.map {
            
            let controller = NavBarController(rootViewController: getController(for: $0))
            controller.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.title(for: $0), 
                                                 image: Resources.Images.TabBar.image(for: $0),
                                                 tag: $0.rawValue)
            
            return controller
        }
        
        setViewControllers(controllers, animated: false)
    }
    
    private func getController(for tab: Controllers) -> BaseController {
        switch tab {
        case .menu:
            return MenuRouter.createModule()
        case .contacts:
            return ContactsController()
        case .profile:
            return ProfileController()
        case .bag:
            return BagController()
        }
    }

}

