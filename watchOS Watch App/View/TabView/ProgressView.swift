//
//  MainView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var healthStore: HealthStore
    @Binding var fillLevel: Int
    @AppStorage("dailyIronGoal") var dailyIronGoal: Int = 18
    @State var showText: Bool = false
    @State private var isBouncing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !showText {
                    Image("RBC")
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            GeometryReader { geometry in
                                Rectangle()
                                    .foregroundColor(.black)
                                    .opacity(0.6)
                                    .frame(height: fillHeight(for: geometry.size.height))
                            }
                        )
                        .frame(height: 140)
                } else {
                    Text("""
                         \(fillLevel)
                         of \(dailyIronGoal)
                         """)
                    .frame(width: 90, alignment: .center)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                }
            }
            .scaleEffect(isBouncing ? 1.05 : 1.0)
            .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: isBouncing)
            .onTapGesture {
                playHaptic()
                withAnimation {
                    isBouncing.toggle()
                    showText.toggle()
                }
                
            }
            .onAppear {
                healthStore.requestAuthorization()
                updateFillLevel()
            }
        }
    }
    
    private func fillHeight(for totalHeight: CGFloat) -> CGFloat {
        return totalHeight * ((CGFloat(dailyIronGoal) - CGFloat(fillLevel)) / CGFloat(dailyIronGoal))
    }
    
    private func playHaptic() {
        WKInterfaceDevice.current().play(.click)
    }
    
    
    private func updateFillLevel() {
        healthStore.fetchTotalIronConsumedToday { totalIron in
            fillLevel = Int(totalIron)
        }
        
    }
    
}
