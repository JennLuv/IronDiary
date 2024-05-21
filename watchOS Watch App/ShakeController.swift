//
//  ShakeController.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import Foundation
import CoreMotion

class ShakeController: ObservableObject {
    private let motionManager = CMMotionManager()
    private var lastShakeTime: Date?
    @Published var ingredient: Ingredient
    
    init(initialIngredient: Ingredient) {
        self.ingredient = initialIngredient
        startDetectingShakes()
    }
    
    private func startDetectingShakes() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let acceleration = data?.acceleration {
                    let threshold = 2.5 // Adjust threshold to detect shake
                    if (fabs(acceleration.x) > threshold || fabs(acceleration.y) > threshold || fabs(acceleration.z) > threshold) {
                        self.handleShakeEvent()
                    }
                }
            }
        }
    }
    
    private func handleShakeEvent() {
        let now = Date()
        if let lastShakeTime = lastShakeTime {
            if now.timeIntervalSince(lastShakeTime) < 1.0 {
                // Prevents multiple shakes being detected within a short period
                return
            }
        }
        lastShakeTime = now
        
        DispatchQueue.main.async {
            let ingredients = Ingredient.getIngredientsData()
            self.ingredient = ingredients.randomElement()!
        }
    }
}
