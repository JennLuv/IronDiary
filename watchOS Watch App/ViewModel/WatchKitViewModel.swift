//
//  WatchKitViewModel.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 27/05/24.
//

import SwiftUI
import WatchKit

class WatchKitViewModel: ObservableObject {
    func playHaptic() {
        WKInterfaceDevice.current().play(.click)
    }
}

