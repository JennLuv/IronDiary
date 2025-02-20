//
//  IngredientsRecords.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import SwiftUI

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

    private func addUsageRecord(name: String) {
        let newRecord = IngredientUsageRecord(name: name, timestamp: Date())
        usageRecords.append(newRecord)
    }
    
    var groupedRecords: [String: [IngredientUsageRecord]] {
        let today = Calendar.current.startOfDay(for: Date())
        
        let todayRecords = usageRecords.filter { record in
            Calendar.current.isDate(record.timestamp, inSameDayAs: today)
        }

        return Dictionary(grouping: todayRecords) { record in
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
    
    func saveUsageRecord(ingredient: Ingredient) {
        addUsageRecord(name: ingredient.ingredientDescription)
    }
}

