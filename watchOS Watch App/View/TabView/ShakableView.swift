//
//  ShackableView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI
import HealthKit
import WatchKit

struct ShakableView: View {
    
    @Binding var ingredient: Ingredient
    @State var ingredientisPresent: Bool = false
    @Binding var fillLevel: Int
    @ObservedObject var shakeController: ShakeController
    @ObservedObject var watchKitViewModel: WatchKitViewModel
    
    var body: some View {

        VStack {
            if ingredientisPresent {
                CardView(ingredient: $ingredient, fillLevel: $fillLevel, watchKitViewModel: watchKitViewModel)
                    .padding()
            } else {
                Text("Shake to choose an ingredient")
                    .padding(.horizontal, 10)
            }
            
        }
        .frame(height: 190)
        .onReceive(shakeController.$isShaked, perform: { isShaken in
            if isShaken {
                ingredientisPresent = true
            }
        })
        
    }
}
