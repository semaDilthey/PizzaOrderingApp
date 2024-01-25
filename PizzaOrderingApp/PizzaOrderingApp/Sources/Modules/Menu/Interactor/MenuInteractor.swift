//
//  MenuInteractor.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    var presenter: MenuInteractorOutputProtocol? { get set }
    var networkManager : Networking { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchData()
    func getItemCount() -> Int
    func getItem(at index: Int) -> MenuModelProtocol?
    func getIndex(of category: String) -> Int
}

protocol MenuInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveMenuItems(_ items: [Menu])
    func onError(_: Error)
}

class MenuInteractor : MenuInteractorInputProtocol {
    
    var networkManager: Networking
    weak var presenter: MenuInteractorOutputProtocol?
    var storageManager : StorageProtocol
    
    init(networkManager: Networking = NetworkManager(), storageManager: StorageProtocol = CoreDataManager.shared) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
    var menuItems : [Menu] = []
    
    func fetchData() {
        self.networkManager.getMenu { [weak self] menus in
            switch menus {
            case .success(let menu):
                DispatchQueue.main.async {
                    self?.succesLoading(get: menu)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.failureLoading(error: error)
                }
                
            }
        }
    }
    
    private func succesLoading(get menu : [Menu]) {
        menuItems = menu
        presenter?.didRetrieveMenuItems(menu)
        // Это для того, чтобы в кордату не грузило лишнее. Пока число меньше 3, то загружаем туда обхекты. Если уже больше 3, то не грузим.
        if storageManager.fetchMenusFromCoreData()?.count ?? 0 <= 3 {
            storageManager.saveMenuToCoreData(menus: menu)
        }
    }
    
    private func failureLoading(error: Error) {
        print(error.localizedDescription)
        if let localMenu = storageManager.fetchMenusFromCoreData() {
            // Ну и собсна когда у нас приходит invalidResponse, то загружаем объекты по ячейкам.
            menuItems = localMenu
            presenter?.didRetrieveMenuItems(localMenu)
        }
    }
    
    func getItemCount() -> Int {
        let items = menuItems.flatMap { $0.foods }
        return items.count
    }
    
    func getItem(at index: Int) -> MenuModelProtocol? {
        guard index <= getItemCount() else { return nil }
        var items : [Food] = []
        var categories : [String] = []
        for food in menuItems {
            for foody in food.foods {
                categories.append(food.name)
                items.append(foody)
            }
        }
        return MenuModel(imageUrl: items[index].img, name: items[index].name, description: items[index].description, price: items[index].price, category: categories[index])
    }
    
    private func getCategories() -> [String] {
        menuItems.compactMap{ $0.name }
    }
    
    func getIndex(of category: String) -> Int {
        var indexOf = 0
        for (index, item) in self.getCategories().enumerated() {
               if item == category {
                  indexOf = index
               }
           }
        return indexOf
    }
    
//    func collectionSctrollToSelectedIndex(of category: String) -> Int? {
//
//        let models = menuItems
//        var minIndex = 0
//        var maxIndex = self.getCategories().count - 1
//        
//        while minIndex <= maxIndex {
//            
//                let midIndex = (minIndex + maxIndex) / 2
//                let midModel = models[midIndex]
//                
//            if midModel.name == category {
//                    // Найдена модель с указанным номером
//                    return midIndex
//                } else if midModel.name != category {
//                    minIndex = midIndex + 1
//                } else {
//                    maxIndex = midIndex - 1
//                }
//            }
//        return nil
//    }
}

