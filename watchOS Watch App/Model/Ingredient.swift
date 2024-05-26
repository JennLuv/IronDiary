//
//  Ingredient.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 21/05/24.
//

import Foundation
import Combine
import SwiftUI


struct Ingredient: Identifiable, Equatable {
    var id: Int
    var imageName: String
    var ingredientDescription: String
    var ironValue: Int
    
    init(id: Int, imageName: String, ingredientDescription: String, ironValue: Int) {
        self.id = id
        self.imageName = imageName
        self.ingredientDescription = ingredientDescription
        self.ironValue = ironValue
    }
    
    static func getIngredientsData() -> [Ingredient] {
        return [
            Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "100g of Beef", ironValue: 3),
            Ingredient(id: 2, imageName: "PoultryImage", ingredientDescription: "100g of Chicken", ironValue: 1),
            Ingredient(id: 3, imageName: "SeafoodImage", ingredientDescription: "100g of Sardines", ironValue: 3),
            Ingredient(id: 4, imageName: "FruitImage", ingredientDescription: "100g of Cherries", ironValue: 1),
            Ingredient(id: 5, imageName: "SeedsNutsImage", ingredientDescription: "100g of Almonds", ironValue: 4),
            Ingredient(id: 6, imageName: "GreensImage", ingredientDescription: "100g of Spinach", ironValue: 3),
        ]
    }

    
}
