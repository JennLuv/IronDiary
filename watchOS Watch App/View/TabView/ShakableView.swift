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
    @Binding var isRerolled: Bool
    @Binding var fillLevel: Int
    
    var body: some View {
        
        ScrollView {
            VStack {
                if ingredientisPresent {
                    CardView(ingredient: $ingredient, fillLevel: $fillLevel)
                        .padding()
                } else {
                    Spacer()
                    Text("Shake to choose an ingredient")
                        .padding(.horizontal, 10)
                    
                    Spacer()
                    Button(action: {
                        isRerolled.toggle()
                        ingredientisPresent = true
                        playHaptic()
                    }) {
                        Text("Start")
                    }
                    .background(Color.accentColor)
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    
                }
                
            }
            .frame(height: 190)
            if ingredientisPresent {
                Button(action: {
                    isRerolled.toggle()
                    ingredientisPresent = true
                    playHaptic()
                }) {
                    Text("Reroll Ingredient")
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .frame(height: 190)
        
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.directionUp)
    }
    
}
