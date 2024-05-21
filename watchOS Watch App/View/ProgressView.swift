//
//  MainView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 20/05/24.
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var healthStore: HealthStore
    @State private var fillLevel: CGFloat = 1

    var body: some View {
        NavigationStack {
            VStack {

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
            }
        }
        .onAppear {
            healthStore.requestAuthorization()
        }
        .navigationTitle("Iron Chef")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fillHeight(for totalHeight: CGFloat) -> CGFloat {
        return totalHeight * ((18 - fillLevel) / 18)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
