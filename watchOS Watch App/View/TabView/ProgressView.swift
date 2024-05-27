//
//  MainView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI
import WidgetKit

struct ProgressView: View {
    @EnvironmentObject var healthStore: HealthStore
    @Binding var fillLevel: Int
    @AppStorage("dailyIronGoal") var dailyIronGoal: Int = 18
    @State var showText: Bool = false
    @State private var isBouncing: Bool = false
    @ObservedObject var watchKitViewModel: WatchKitViewModel
    
    
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
                                    .frame(height: healthStore.fillHeight(dailyIronGoal: dailyIronGoal, for: geometry.size.height))
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
                watchKitViewModel.playHaptic()
                withAnimation {
                    isBouncing.toggle()
                    showText.toggle()
                }
                
            }
            .onAppear {
                healthStore.requestAuthorization()
                healthStore.updateFillLevel()
            }
        }
    }
    
}
