//
//  FoodEntity+CoreDataClass.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 24.01.2024.
//
//

import Foundation
import CoreData

@objc(FoodEntity)
public class FoodEntity: NSManagedObject {

}

extension FoodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntity> {
        return NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var img: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int16

}

extension FoodEntity : Identifiable {

}

