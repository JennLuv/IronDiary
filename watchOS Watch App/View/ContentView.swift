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
    @State var isRerolled: Bool = false
    @ObservedObject var healthStore: HealthStore
    @ObservedObject var shakeController: ShakeController
    @ObservedObject var ingredientViewModel = IngredientViewModel(ingredient: Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "100g of Beef", ironValue: 3))
    
    var body: some View {
        TabView(selection: $selection) {
            ProgressView(fillLevel: $healthStore.fillLevel).tag(Tab.main)
                .onAppear{
                    shakeController.stopDetectingShakes()
                }
            
            ShakableView(ingredient: $ingredientViewModel.ingredient, fillLevel: $healthStore.fillLevel, shakeController: shakeController).tag(Tab.shakable)
                .onAppear {
                    shakeController.startDetectingShakes()
                }
                .onChange(of: shakeController.isShaked) { oldValue, newValue in
                    ingredientViewModel.getRandomIngredient()
                    playHaptic()
                }
            
            IngredientsRecordsView().tag(Tab.records)
                .onAppear{
                    shakeController.stopDetectingShakes()
                }
                
            IronConsumptionChartView().tag(Tab.data)
                
            
        }
        .tabViewStyle(.verticalPage)
        .onChange(of: isRerolled) { oldValue, newValue in
            ingredientViewModel.getRandomIngredient()
        }
        
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.directionUp)
    }
    
}
