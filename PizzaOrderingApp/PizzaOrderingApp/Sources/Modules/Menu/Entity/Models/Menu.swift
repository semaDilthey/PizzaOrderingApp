//
//  Menu.swift
//  PizzaOrderingApp
//
//  Created by Семен Гайдамакин on 18.01.2024.
//

import UIKit


public struct Menu : Decodable {
    let id : Int
    let name : String
    let foods : [Food]
}

struct Food : Decodable {
    let id : Int
    let name : String
    let img : String
    let price : Int
    let description : String
}
