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
    
    init(id: Int, imageName: String, ingredientDescription: String, ironValue: Int) {
        self.id = id
        self.imageName = imageName
        self.ingredientDescription = ingredientDescription
        self.ironValue = ironValue
    }
    
    static func getIngredientsData() -> [Ingredient] {
        return [
            Ingredient(id: 1, imageName: "MeatImage", ingredientDescription: "100g of Beef", ironValue: 3),
            Ingredient(id: 2, imageName: "PoultryImage", ingredientDescription: "100g of Chicken", ironValue: 1),
            Ingredient(id: 3, imageName: "SeafoodImage", ingredientDescription: "100g of Sardines", ironValue: 3),
            Ingredient(id: 4, imageName: "FruitImage", ingredientDescription: "100g of Cherries", ironValue: 1),
            Ingredient(id: 5, imageName: "SeedsNutsImage", ingredientDescription: "100g of Almonds", ironValue: 4),
            Ingredient(id: 6, imageName: "GreensImage", ingredientDescription: "100g of Spinach", ironValue: 3),
        ]
    }

    
}

struct DataElement: Identifiable {
    var id = UUID()
    var date: Date
    var itemsComplete: Double
}

struct IngredientUsageRecord: Identifiable, Codable, Equatable {
    
    var id = UUID()
    let name: String
    let timestamp: Date
    
    init(name: String, timestamp: Date) {
            self.id = UUID()
            self.name = name
            self.timestamp = timestamp
        }
}

class IngredientsRecords: ObservableObject {
    @Published var usageRecords: [IngredientUsageRecord] = [] {
        didSet {
            saveUsageRecords()
        }
    }
    
    @AppStorage("usageRecords") private var usageRecordsData: Data = Data()
    
    init() {
        loadUsageRecords()
    }

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
    
    private func saveUsageRecords() {
        do {
            let data = try JSONEncoder().encode(usageRecords)
            usageRecordsData = data
        } catch {
            print("Failed to save usage records: \(error.localizedDescription)")
        }
    }
    
    private func loadUsageRecords() {
        do {
            let data = usageRecordsData
            usageRecords = try JSONDecoder().decode([IngredientUsageRecord].self, from: data)
        } catch {
            print("Failed to load usage records: \(error.localizedDescription)")
        }
    }
}

