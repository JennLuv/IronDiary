//
//  IngredientsRecordsView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 22/05/24.
//

import SwiftUI

struct IngredientsRecordsView: View {
    @EnvironmentObject var ingredientsRecords: IngredientsRecords
    
    var body: some View {
        if ingredientsRecords.sortedGroupedRecords.isEmpty {
            Text("Start by consuming an ingredient")
        } else {
            List {
                ForEach(ingredientsRecords.sortedGroupedRecords, id: \.key) { section in
                    Section(header:
                                Text(section.key)
                        .foregroundStyle(Color.accentColor)
                        .bold()
                        .font(.subheadline)
                            
                    ) {
                        ForEach(section.value) { record in
                            VStack(alignment: .leading) {
                                Text(record.name)
                            }
                        }
                    }
                }
            }
            .listStyle(.carousel)
        }
        
    }
}

