//
//  watchOSApp.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import SwiftUI

@main
struct watchOS_Watch_AppApp: App {
    @State private var healthStore = HealthStore()
    @State var fillLevel: Int = 1
    @StateObject var shakeController = ShakeController()
    @State private var ingredientRecords = IngredientsRecords()
    
    var body: some Scene {
        WindowGroup {
            ContentView(fillLevel: $fillLevel, shakeController: shakeController)
        }
        .environmentObject(ingredientRecords)
        .environmentObject(healthStore)
        
    }
}
