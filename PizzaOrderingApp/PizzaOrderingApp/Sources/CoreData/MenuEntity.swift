//
//  MenuEntity+CoreDataClass.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 24.01.2024.
//
//

import Foundation
import CoreData

@objc(MenuEntity)
public class MenuEntity: NSManagedObject {

}

extension MenuEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuEntity> {
        return NSFetchRequest<MenuEntity>(entityName: "MenuEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var foods: NSOrderedSet?

}

// MARK: Generated accessors for foods
extension MenuEntity {

    @objc(insertObject:inFoodsAtIndex:)
    @NSManaged public func insertIntoFoods(_ value: FoodEntity, at idx: Int)

    @objc(removeObjectFromFoodsAtIndex:)
    @NSManaged public func removeFromFoods(at idx: Int)

    @objc(insertFoods:atIndexes:)
    @NSManaged public func insertIntoFoods(_ values: [FoodEntity], at indexes: NSIndexSet)

    @objc(removeFoodsAtIndexes:)
    @NSManaged public func removeFromFoods(at indexes: NSIndexSet)

    @objc(replaceObjectInFoodsAtIndex:withObject:)
    @NSManaged public func replaceFoods(at idx: Int, with value: FoodEntity)

    @objc(replaceFoodsAtIndexes:withFoods:)
    @NSManaged public func replaceFoods(at indexes: NSIndexSet, with values: [FoodEntity])

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: FoodEntity)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: FoodEntity)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSOrderedSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSOrderedSet)

}

extension MenuEntity : Identifiable {

}
