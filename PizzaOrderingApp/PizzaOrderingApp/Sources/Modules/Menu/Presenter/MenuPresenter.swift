//
//  MenuPresenter.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject {
    var view: MenuViewProtocol? { get set }
    var interactor: MenuInteractorInputProtocol? { get set }
    var router: MenuRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func selectCategory(category: String)
    func getItemCount() -> Int
    func getItem(at index: Int) -> MenuModelProtocol?
}

class MenuPresenter : MenuPresenterProtocol {
    
    var view: MenuViewProtocol?
    
    var interactor: MenuInteractorInputProtocol?
    
    var router: MenuRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    // Относится к выбору в хедере, получаем индекс выбранной ячейки
    func selectCategory(category: String) {
        guard let ctgr = interactor?.getIndex(of: category) else { return }
        view?.scrollTo(index: ctgr)
    }
    
    func getItemCount() -> Int {
        guard let itemsAmount = interactor?.getItemCount() else { return 0 }
        return itemsAmount
    }
    
    func getItem(at index: Int) -> MenuModelProtocol? {
        interactor?.getItem(at: index)
    }
}

extension MenuPresenter : MenuInteractorOutputProtocol {
    
    func didRetrieveMenuItems(_ items: [Menu]) {
        view?.showMenuItems(items: items)
    }
    
    func onError(_: Error) {
        
    }
    
    
}
