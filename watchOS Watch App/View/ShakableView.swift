//
//  ShackableView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI

struct ShakableView: View {
    
    @StateObject private var shakeController = ShakeController(initialIngredient: Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "10g of Beef", ironValue: 2))
    @State private var isShared: Bool = false
    
    var body: some View {
        VStack {
            if isShared {
                CardView(ingredient: shakeController.ingredient)
            } else {
                Text("Shake to choose ingredient")
                    .font(.custom("SF Compact", size: 25))
                    .padding()
            }
        }
        .onChange(of: shakeController.ingredient, { oldValue, newValue in
            isShared = true
        })
        
    }
}

#Preview {
    ShakableView()
}
