//
//  BaseController.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}

class BaseController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addViews()
        layoutViews()
    }
}


@objc extension BaseController {
    
    func configure() {
        view.backgroundColor = Resources.Colors.background
    }
    func layoutViews() {}
    func addViews() {}
    
    func navBarLeftItemHandler() {
        print("City selector was tapped")
    }
    
    func navBarRightItemHandler() {
        print("Other item was tapped")
    }
    
}

extension BaseController {
    
    func addNavBarItem(at position: NavBarPosition, title : String? = nil) {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(Resources.Colors.inActive, for: .disabled)
        button.titleLabel?.font = UIFont.SD.UIDisplayFont(size: 17, weight: .medium)
        
        switch position {
        case .left:
            let leftButton = LocationButton()
            leftButton.addTarget(self, action: #selector(navBarLeftItemHandler), for: .touchUpInside)
            leftButton.setTitle(title ?? "Москва")
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            if let title {
                navigationItem.leftBarButtonItem?.width = (title as NSString).size(withAttributes: [.font : button.titleLabel?.font as Any]).width + 22
            } else {
                navigationItem.leftBarButtonItem?.width = ("Москва" as NSString).size(withAttributes: [.font : button.titleLabel?.font as Any]).width + 22
            }
        case .right:
            
            button.addTarget(self, action: #selector(navBarRightItemHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}
