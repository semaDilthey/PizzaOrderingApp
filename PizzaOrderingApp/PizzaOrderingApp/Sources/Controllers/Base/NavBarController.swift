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
        view.backgroundColor = Resources.Colors.background
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor : Resources.Colors.active,  
                                                                .font : UIFont.SD.UIDisplayFont(size: 17, weight: .medium) as Any]
    }
}
