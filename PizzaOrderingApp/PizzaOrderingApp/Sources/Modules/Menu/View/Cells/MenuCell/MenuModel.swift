//
//  MenuModel.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import Foundation

protocol MenuModelProtocol {
    var category : String { get set }
    var imageUrl: String { get set }
    var name : String { get set }
    var description : String { get set }
    var price : Int { get set }
}

struct MenuModel : MenuModelProtocol {
    var imageUrl: String
    
    var name: String
    
    var description: String
    
    var price: Int
    var category : String 
}
