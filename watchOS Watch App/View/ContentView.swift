//
//  ContentView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 19/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .main
    
    enum Tab {
        case main, shakable, data
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MainView().tag(Tab.main)
            ShakableView().tag(Tab.shakable)
        }
        .tabViewStyle(.verticalPage)
        }
    
        
}

#Preview {
    ContentView()
}
