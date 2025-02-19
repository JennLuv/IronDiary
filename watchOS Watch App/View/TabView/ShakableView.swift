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
    
    var body: some View {
        ScrollView{
            VStack {
                Spacer()
                if ingredientisPresent {
                    CardView(ingredient: $ingredient, fillLevel: $fillLevel)
                        .padding()
                } else {
                    Text("Shake to choose an ingredient")
                        .padding(.horizontal, 10)
                }
                Spacer()
                Button(action: {
                    shakeController.handleShakeEvent()
                    print(shakeController.isShaked)
                }) {
                    Text("Simulate Shake")
                }
                .background(Color.accentColor)
                .opacity(0.5)
                .cornerRadius(30)
                Spacer()
                
            }
            .frame(height: 190)
            .onReceive(shakeController.$isShaked, perform: { isShaken in
                if isShaken {
                    ingredientisPresent = true
                }
            })
        }
        
    }
}
