//
//  NavBarController.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

final class NavBarController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = Resources.Colors.background
        navBarAppearance.titleTextAttributes = [.foregroundColor : Resources.Colors.active,
                                                .font : UIFont.SD.UIDisplayFont(size: 17, weight: .medium) as Any]
        navBarAppearance.shadowColor = Resources.Colors.background
      
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.isTranslucent = false

    }
}
