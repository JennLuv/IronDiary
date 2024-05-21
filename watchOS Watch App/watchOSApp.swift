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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(healthStore)
        
    }
}
