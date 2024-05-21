//
//  CardView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI

struct CardView: View {
    
    @State var ingredient: Ingredient
    
    var body: some View {
        
        VStack {
            Spacer()
            Image(ingredient.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 75)
            Text(ingredient.ingredientDescription)
            Spacer()
        }
        .frame(height: 140)
        Button(action: {
            // Action for button
        }, label: {
            Text("Use Ingredient")
        })
    }
}

#Preview {
    CardView(ingredient: Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "10g of Beef", ironValue: 2))
}
