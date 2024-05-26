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
    
    func requestAuthorization() {

        let typesToShare: Set = [
            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!
        ]

        let typesToRead: Set = [
            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!
        ]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
        }

    }
    
    func fetchTotalIronConsumedToday(completion: @escaping (Double) -> Void) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: ironType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            var totalIron: Double = 0.0
            
            if let result = result, let sum = result.sumQuantity() {
                totalIron = sum.doubleValue(for: .gramUnit(with: .milli))
            }
            
            DispatchQueue.main.async {
                completion(totalIron)
            }
        }
        
        healthStore.execute(query)
    }
    

    
}
