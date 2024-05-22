//
//  Ingredient.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 21/05/24.
//

import Foundation


struct Ingredient: Identifiable, Equatable {
    var id: Int
    var imageName: String
    var ingredientDescription: String
    var ironValue: Int
    
    init(id: Int, imageName: String, ingredientDescription: String, ironValue: Int) {
        self.id = id
        self.imageName = imageName
        self.ingredientDescription = ingredientDescription
        self.ironValue = ironValue
    }
    
    static func getIngredientsData() -> [Ingredient] {
        return [
            Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "10g of Beef", ironValue: 2),
            Ingredient(id: 2, imageName: "PoultryImage", ingredientDescription: "10g of Chicken", ironValue: 1),
            Ingredient(id: 3, imageName: "SeafoodImage", ingredientDescription: "10g of Sardines", ironValue: 3),
            Ingredient(id: 4, imageName: "FruitImage", ingredientDescription: "10g of Cherry", ironValue: 4),
            Ingredient(id: 5, imageName: "SeedsNutsImage", ingredientDescription: "10g of Almonds", ironValue: 2),
            Ingredient(id: 6, imageName: "GreensImage", ingredientDescription: "10g of Broccoli", ironValue: 1),
        ]
    }
    
}

struct DataElement: Identifiable {
    var id = UUID()
    var date: Date
    var itemsComplete: Double
}

struct IngredientUsageRecord: Identifiable {
    
    let id = UUID()
    let name: String
    let timestamp: Date
}

class IngredientsRecords: ObservableObject {

    @Published var usageRecords: [IngredientUsageRecord] = []
    
    func addUsageRecord(name: String) {
        let newRecord = IngredientUsageRecord(name: name, timestamp: Date())
        usageRecords.append(newRecord)
    }
    
    var groupedRecords: [String: [IngredientUsageRecord]] {
            Dictionary(grouping: usageRecords) { record in
                let formatter = DateFormatter()
                formatter.dateStyle = .none
                formatter.timeStyle = .short
                return formatter.string(from: record.timestamp)
            }
        }

        var sortedGroupedRecords: [(key: String, value: [IngredientUsageRecord])] {
            groupedRecords.sorted { $0.key > $1.key }
        }
}

