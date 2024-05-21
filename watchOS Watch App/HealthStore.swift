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
//    var builder: HKLiveWorkoutBuilder?
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        // The quantity type to write to the health store.
        let typesToShare: Set = [
//            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!
        ]

        // The quantity types to read from the health store.
        let typesToRead: Set = [
//            HKSampleType.clinicalType(forIdentifier: HKClinicalTypeIdentifier.medicationRecord)!
            HKCorrelationType.quantityType(forIdentifier: .dietaryIron)!
//            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
//            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
//            HKObjectType.activitySummaryType()
        ]

        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error.
        }
//        healthStore.requestPerObjectReadAuthorization(for: HKSampleType.clinicalType(forIdentifier: HKClinicalTypeIdentifier.medicationRecord)!, predicate: nil) { success, error in
//            print(success)
//        }
    }
}
