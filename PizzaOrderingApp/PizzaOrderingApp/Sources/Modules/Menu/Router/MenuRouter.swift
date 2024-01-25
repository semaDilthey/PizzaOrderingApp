//
//  MenuRouter.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

protocol MenuRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createModule() -> BaseController
}

final class MenuRouter : MenuRouterProtocol {
    static func createModule() -> BaseController {
        let interactor = MenuInteractor()
        let presenter = MenuPresenter()
        presenter.interactor = interactor
        interactor.presenter = presenter
        let view = MenuController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    
}
