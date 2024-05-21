//
//  IronConsumptionChartView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 21/05/24.
//

import SwiftUI
import Charts

struct IronConsumptionChartView: View {
    @EnvironmentObject var healthStore: HealthStore
    @State private var data: [DataElement] = []
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()
    
    private var currentDate: String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    private var timeRangeText: String {
            guard let start = data.first?.date, let end = data.last?.date else {
                return "00:00 - 00:00"
            }
            let startTime = timeFormatter.string(from: start)
            let endTime = timeFormatter.string(from: end)
            return "\(startTime) - \(endTime)"
        }
    
    var body: some View {
        
        VStack {
            Chart(data) { dataPoint in
                BarMark(
                    x: .value("Time", dataPoint.date, unit: .hour),
                    y: .value("Iron (mg)", dataPoint.itemsComplete)
                )
                .foregroundStyle(Color.accentColor)
                .cornerRadius(30, style: .circular)
            }
            .frame(height: 100)
            
            HStack {
                Text(currentDate)
                    .font(.title3)
                Spacer()
            }
            Spacer()
            HStack {
                Text(timeRangeText)
                    .foregroundStyle(Color.gray)
                Spacer()
            }
        }
        .padding(.trailing, 15)
        .frame(height: 160)
        .onAppear {
            healthStore.fetchIronData { fetchedData in
                self.data = fetchedData
            }
        }
        .frame(height: 200)
    }
}
