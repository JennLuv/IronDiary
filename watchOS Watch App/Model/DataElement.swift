//
//  DataElement.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import SwiftUI

struct DataElement: Identifiable {
    var id = UUID()
    var date: Date
    var itemsComplete: Double
}
