//
//  SuccessView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 21/05/24.
//

import SwiftUI

struct SuccessView: View {
    @Binding var ingredient: Ingredient
    var body: some View {
        VStack{
            
            Image("RBCSmile")
                .resizable()
                .scaledToFit()
                .frame(height:100)
            Spacer()
            Text("Your iron went up by \(ingredient.ironValue) mg!")
            
            
        }
    }
}

