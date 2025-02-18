//
//  Ingredient.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 21/05/24.
//

import Foundation
import Combine
import SwiftUI


struct Ingredient: Identifiable, Equatable {
    var id: Int
    var imageName: String
    var ingredientDescription: String
    var ironValue: Int
}
