//
//  IngredientUsageRecord.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import SwiftUI

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
