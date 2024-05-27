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
    @State var isShakableViewOn: Bool = false
    
    
    enum Tab {
        case main, shakable, records, data
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ProgressView(fillLevel: $fillLevel).tag(Tab.main)
            
            ShakableView(ingredient: $ingredient, fillLevel: $fillLevel, shakeController: shakeController).tag(Tab.shakable)
                .onAppear {
                    shakeController.startDetectingShakes()
                    isShakableViewOn.toggle()
                }
                .onChange(of: shakeController.isShaked) { oldValue, newValue in
                    self.getRandomIngredient()
                    if isShakableViewOn {
                        playHaptic()
                    }
                }
                .onDisappear {
                    shakeController.stopDetectingShakes()
                    isShakableViewOn.toggle()
                }
            IngredientsRecordsView().tag(Tab.records)
                
            IronConsumptionChartView().tag(Tab.data)
                
            
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
