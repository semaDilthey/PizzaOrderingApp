//
//  Resources.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

enum Resources {
    
    enum Colors {
        
        static var active = UIColor(hexString: "#FD3A69")
        static var inActive = UIColor(hexString: "#C3C4C9")
        
        static var separator = UIColor(hexString: "#F3F5F9")
    
    
        static var background = UIColor(hexString: "#F3F5F9")
        static var black = UIColor(hexString: "#222831")
        static var gray = UIColor(hexString: "#AAAAAD")

        
        enum Cells {
            static var selected = UIColor(hexString: "#FD3A69")
            static var unSelected = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4)

        }
    }
    
    enum Images {
        
        enum TabBar {
            
            static func image(for tab: Controllers) -> UIImage? {
                switch tab {
                case .menu:
                    UIImage(named: "menu_tab")?.withRenderingMode(.alwaysTemplate)
                case .contacts:
                    UIImage(named: "contacts_tab")?.withRenderingMode(.alwaysTemplate)
                case .profile:
                    UIImage(named: "profile_tab")?.withRenderingMode(.alwaysTemplate)
                case .bag:
                    UIImage(named: "bag_tab")?.withRenderingMode(.alwaysTemplate)
                }
            }
            
        }
 
        enum Menu {
            static var location = UIImage(named: "arrowDown_navBar")?.withRenderingMode(.alwaysTemplate)

        }
    }
    
    enum Strings {
        
        enum TabBar {
            
            static func title(for tab: Controllers) -> String? {
                switch tab {
                case .menu:
                    "Меню"
                case .contacts:
                    "Контакты"
                case .profile:
                    "Профиль"
                case .bag:
                    "Корзина"
                }
            }
            static var menu = "Меню"
            static var contacts = "Контакты"
            static var profile = "Профиль"
            static var bag = "Корзина"
        }
        
    }
    
}
