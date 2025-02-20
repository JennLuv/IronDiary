//
//  IngredientViewModel.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 27/05/24.
//

import SwiftUI

class IngredientViewModel: ObservableObject {
    
    @Published var ingredient: Ingredient
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
    
    func getIngredientsData() -> [Ingredient] {
        return [
            Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "100g of Beef", ironValue: 3),
            Ingredient(id: 2, imageName: "PoultryImage", ingredientDescription: "100g of Chicken", ironValue: 1),
            Ingredient(id: 3, imageName: "SeafoodImage", ingredientDescription: "100g of Sardines", ironValue: 3),
            Ingredient(id: 4, imageName: "FruitImage", ingredientDescription: "100g of Cherries", ironValue: 1),
            Ingredient(id: 5, imageName: "SeedsNutsImage", ingredientDescription: "100g of Almonds", ironValue: 4),
            Ingredient(id: 6, imageName: "GreensImage", ingredientDescription: "100g of Spinach", ironValue: 3),
        ]
    }
    
    func getRandomIngredient() {
        let ingredients = self.getIngredientsData()
        DispatchQueue.global().async {
            var newIngredient: Ingredient
            repeat {
                newIngredient = ingredients.randomElement()!
            } while newIngredient.id == self.ingredient.id

            DispatchQueue.main.async {
                self.ingredient = newIngredient
            }
        }
    }
}

