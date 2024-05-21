//
//  WorkoutManager.swift
//  trialWatch Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import Foundation
import HealthKit

class HealthStore: NSObject, ObservableObject {
    
    let healthStore = HKHealthStore()
    let ironType = HKQuantityType.quantityType(forIdentifier: .dietaryIron)!
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {

        let typesToShare: Set = [
            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!
        ]

        // The quantity types to read from the health store.
        let typesToRead: Set = [

            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!

        ]

        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
        }

    }
    
    func saveIronData(ironValue: Double) {
            let ironQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: ironValue)
            let now = Date()
            let sample = HKQuantitySample(type: ironType, quantity: ironQuantity, start: now, end: now)
            
            healthStore.save(sample) { success, error in
                if success {
                    print("Iron data saved to HealthKit")
                } else {
                    if let error = error {
                        print("Error saving iron data: \(error.localizedDescription)")
                    }
                }
            }
        }
    func fetchIronData(completion: @escaping ([DataElement]) -> Void) {
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: Date())
            let endDate = Date()
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            
            let query = HKStatisticsCollectionQuery(
                quantityType: ironType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: startDate,
                intervalComponents: DateComponents(minute: 1)
            )
            
            query.initialResultsHandler = { query, results, error in
                var dataElements = [DataElement]()
                
                results?.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let ironValue = quantity.doubleValue(for: .gramUnit(with: .milli))
                        let dataElement = DataElement(date: statistics.startDate, itemsComplete: ironValue)
                        dataElements.append(dataElement)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(dataElements)
                }
            }
            
            healthStore.execute(query)
        }
    
}
