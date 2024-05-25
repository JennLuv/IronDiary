//
//  OnboardingView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 25/05/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("dailyIronGoal") private var dailyIronGoal: Int = 0
    @State private var selectedGoal: Int = 18
    
    var body: some View {
        VStack {
            Text("Set Your Daily Goal")
                .font(.headline)
                .padding()

            Picker("Daily Iron Goal", selection: $selectedGoal) {
                ForEach(1..<101) { value in
                    Text("\(value) mg").tag(value)
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
            .padding(.horizontal)

            Button(action: {
                dailyIronGoal = selectedGoal
                playHaptic()
            }) {
                Text("Save")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(30)
            .padding()
        }
        .navigationTitle("Onboarding")
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.start)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
