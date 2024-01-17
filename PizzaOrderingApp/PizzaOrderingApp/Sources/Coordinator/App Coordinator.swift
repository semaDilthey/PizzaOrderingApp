//
//  App Coordinator.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 16.01.2024.
//

import UIKit

//class AppCoordinator: Coordinator {
//    
//    var childControllers : [Coordinator] = []
//    var parentCoordinator: Coordinator?
//    var navigationController: UINavigationController
//    
//    private let controllerFactory: ControllerFactory = AppControllerFactory()
//    
//    var window : UIWindow?
//    
//    init(navigationController : UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let mainViewModel = MainViewModel(coordinator: self)
//        let mainViewController = controllerFactory.makeController(controller: .mainController(viewModel: mainViewModel), coordinator: self)
//        navigationController = UINavigationController(rootViewController: mainViewController)
//        if let window {
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//    }
//    
//    func navigateTo(controller: Controllers) {
//       let controller = controllerFactory.makeController(controller: controller, coordinator: self)
//        navigationController.pushViewController(controller, animated: true)
//        print(childControllers)
//    }
//}
