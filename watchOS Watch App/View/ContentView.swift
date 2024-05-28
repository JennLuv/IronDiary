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
    @State var isShakableViewOn: Bool = false
    @ObservedObject var ingredientViewModel = IngredientViewModel(ingredient: Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "100g of Beef", ironValue: 3))
    
    var body: some View {
        TabView(selection: $selection) {
            ProgressView(fillLevel: $healthStore.fillLevel).tag(Tab.main)
            
            ShakableView(ingredient: $ingredientViewModel.ingredient, fillLevel: $healthStore.fillLevel, shakeController: shakeController).tag(Tab.shakable)
                .onAppear {
                    shakeController.startDetectingShakes()
                    isShakableViewOn.toggle()
                }
                .onChange(of: shakeController.isShaked) { oldValue, newValue in
                    ingredientViewModel.getRandomIngredient()
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
            ingredientViewModel.getRandomIngredient()
        }
        
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.directionUp)
    }
    
}
