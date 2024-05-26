//
//  CardView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var healthStore: HealthStore
    @Binding var ingredient: Ingredient
    @State private var isSheetPresented = false
    @Binding var fillLevel: Int
    @EnvironmentObject var ingredientsRecords: IngredientsRecords
    
    var body: some View {
        VStack{
            Spacer()
            VStack {
                Spacer()
                Image(ingredient.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                Text(ingredient.ingredientDescription)
                Spacer()
            }
            Spacer()
            Button(action: {
                saveUsageRecord()
                playHaptic()
                saveIronData()
                isSheetPresented.toggle()
                fillLevel = fillLevel + ingredient.ironValue
            }, label: {
                Text("Use Ingredient")
            })
            .background(Color.accentColor)
            .cornerRadius(30)
            .sheet(isPresented: $isSheetPresented, content: {
                SuccessView(ingredient: $ingredient)
            })
        }
        .frame(height: 190)
    }
    
    private func saveIronData() {
        healthStore.saveIronData(ironValue: Double(ingredient.ironValue))
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.success)
    }
    
    private func saveUsageRecord() {
        ingredientsRecords.addUsageRecord(name: ingredient.ingredientDescription)
        }
    
}
