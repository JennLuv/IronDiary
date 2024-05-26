//
//  AppIntent.swift
//  IronDiaryWidget
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Iron Diary widget.")

    @Parameter(title: "Iron Progress", default: 0)
    var ironProgress: Int
    
    @Parameter(title: "Iron Goal", default: 18)
    var ironDailyGoal: Int
    
}
