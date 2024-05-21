//
//  ContentView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .main
    @State var ingredient: Ingredient = Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "10g of Beef", ironValue: 2)
    @State var isRerolled: Bool = false
    @Binding var fillLevel: Int
    @ObservedObject var shakeController: ShakeController
    
    
    enum Tab {
        case main, shakable, data
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ProgressView(fillLevel: $fillLevel).tag(Tab.main)
            ShakableView(ingredient: $ingredient, isRerolled: $isRerolled, fillLevel: $fillLevel).tag(Tab.shakable)
            IronConsumptionChartView().tag(Tab.data)
        }
        .tabViewStyle(.verticalPage)
        .onChange(of: isRerolled) { oldValue, newValue in
            self.getRandomIngredient()
        }
        .onChange(of: shakeController.isShaked) { oldValue, newValue in
            self.getRandomIngredient()
        }
        
    }
    func getRandomIngredient() {
        let ingredients = Ingredient.getIngredientsData()
        DispatchQueue.global().async {
            self.ingredient = ingredients.randomElement()!
        }
    }
    
}

//#Preview {
//    ContentView()
//}
