//
//  ContentView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var selection: Tab = .main
    @State var ingredient: Ingredient = Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "10g of Beef", ironValue: 2)
    @State var isRerolled: Bool = false
    @Binding var fillLevel: Int
    @ObservedObject var shakeController: ShakeController
    
    
    enum Tab {
        case main, shakable, records, data
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ProgressView(fillLevel: $fillLevel).tag(Tab.main)
                .onAppear {
                    shakeController.stopDetectingShakes()
                }
            ShakableView(ingredient: $ingredient, fillLevel: $fillLevel, shakeController: shakeController).tag(Tab.shakable)
                .onAppear {
                    shakeController.startDetectingShakes()
                }
                .onChange(of: shakeController.isShaked) { oldValue, newValue in
                    self.getRandomIngredient()
                    playHaptic()
                }
                .onDisappear {
                    shakeController.stopDetectingShakes()
                }
            IngredientsRecordsView().tag(Tab.records)
                .onAppear {
                    shakeController.stopDetectingShakes()
                }
            IronConsumptionChartView().tag(Tab.data)
                .onAppear {
                    shakeController.stopDetectingShakes()
                }
            
        }
        .tabViewStyle(.verticalPage)
        .onChange(of: isRerolled) { oldValue, newValue in
            self.getRandomIngredient()
        }
        
    }
    func getRandomIngredient() {
        let ingredients = Ingredient.getIngredientsData()
        DispatchQueue.global().async {
            self.ingredient = ingredients.randomElement()!
        }
    }
    private func playHaptic() {
        WKInterfaceDevice.current().play(.directionUp)
    }
    
}
