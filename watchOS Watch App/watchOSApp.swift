//
//  watchOSApp.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import SwiftUI

@main
struct IronDiary: App {
    @AppStorage("dailyIronGoal") private var dailyIronGoal: Int = 0
    @State private var healthStore = HealthStore()
    @State var fillLevel: Int = 0
    @StateObject var shakeController = ShakeController()
    @State private var ingredientRecords = IngredientsRecords()
    
    var body: some Scene {
        WindowGroup {
            if dailyIronGoal == 0 {
                OnboardingView()
                    .onAppear {
                        healthStore.requestAuthorization()
                        updateFillLevel()
                    }
            } else {
                ContentView(fillLevel: $fillLevel, shakeController: shakeController)
                
            }
        }
        .environmentObject(ingredientRecords)
        .environmentObject(healthStore)
        
    }
    
    private func updateFillLevel() {
        healthStore.fetchTotalIronConsumedToday { totalIron in
            fillLevel = Int(totalIron) // Assuming fillLevel is in mg
        }
    }
}
