//
//  Coordinator.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

protocol Coordinator : AnyObject {
    var childControllers : [Coordinator] { get set }
    var parentCoordinator : Coordinator? { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
//    func navigateTo(controller: Controllers)
}

extension Coordinator {
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
}
