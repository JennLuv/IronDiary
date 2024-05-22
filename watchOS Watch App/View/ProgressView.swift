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
                         of 18
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
                withAnimation {
                    isBouncing.toggle()
                    showText.toggle()
                }
                
            }
            .onAppear {
                healthStore.requestAuthorization()
            }
        }
    }
        
        private func fillHeight(for totalHeight: CGFloat) -> CGFloat {
            return totalHeight * ((18 - CGFloat(fillLevel)) / 18)
        }
    }
    
