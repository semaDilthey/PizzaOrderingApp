//
//  CoreDataManager.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 23.01.2024.
//

import Foundation
import CoreData
import UIKit

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
    case couldNotDeleteObject
    case error(Error)
    
    var localizedDescription: String {
        switch self {
        case .managedObjectContextNotFound:
            "Не удалось найти контекст"
        case .couldNotSaveObject:
            "Не удалось сохранить объект"
        case .objectNotFound:
            "Объект не найден"
        case .couldNotDeleteObject:
            "Не удалось удалить объект"
        case .error(let error):
            error.localizedDescription
        }
    }
}

protocol StorageProtocol {
    func saveMenuToCoreData(menus: [Menu])
    func fetchMenusFromCoreData() -> [Menu]?
    func saveContext()
    func deleteEntities(managedObject: NSManagedObject.Type)
    
}

public final class CoreDataManager : NSObject, StorageProtocol {
    
    public static let shared = CoreDataManager()
    
    private override init() { }
    
    private var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var mainContext: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func saveMenuToCoreData(menus: [Menu]) {
        for menu in menus {
            let menuEntity = MenuEntity(context: mainContext)
            menuEntity.id = Int16(menu.id)
            menuEntity.name = menu.name
            
            for food in menu.foods {
                let foodEntity = FoodEntity(context: mainContext)
                foodEntity.id = Int16(food.id)
                foodEntity.name = food.name
                foodEntity.img = food.img
                foodEntity.itemDescription = food.description
                foodEntity.price = Int16(food.price)
                
                if menuEntity.foods == nil {
                    menuEntity.foods = [foodEntity]
                } else {
                    menuEntity.addToFoods(foodEntity)
                }
            }
        }
        saveContext()
    }
    
    func fetchMenusFromCoreData() -> [Menu]? {
        let fetchRequest: NSFetchRequest<MenuEntity> = MenuEntity.fetchRequest()
        
        do {
            let menuEntities = try mainContext.fetch(fetchRequest)
            let menus = menuEntities.map { menuEntity -> Menu in
                let foods = (menuEntity.foods?.array as? [FoodEntity])?.compactMap { foodEntity -> Food in
                    return Food(id: Int(foodEntity.id), name: foodEntity.name ?? "", img: foodEntity.img ?? "", price: Int(foodEntity.price), description: foodEntity.itemDescription ?? "")
                }
                return Menu(id: Int(menuEntity.id), name: menuEntity.name ?? "", foods: foods!)
            }
            return menus
        } catch {
            print("Error fetching data from CoreData: \(error)")
            return nil
        }
    }

    func saveContext() {
        mainContext.perform { [self] in
            do {
                try mainContext.save()
            } catch {
                print(PersistenceError.couldNotSaveObject)
            }
        }
    }
    
    func deleteEntities(managedObject: NSManagedObject.Type) {
        mainContext.reset()
        guard let notificationEntity = managedObject.entity().name else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: notificationEntity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let container = appDelegate.persistentContainer
            try container.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
        } catch {
             print(PersistenceError.couldNotDeleteObject)
        }
    }
    
}
