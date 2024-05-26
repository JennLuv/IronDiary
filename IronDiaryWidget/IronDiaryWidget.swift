//
//  IronDiaryWidget.swift
//  IronDiaryWidget
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    @AppStorage("IronProgress") var ironProgress: Int = 0
    
    
    func readFillLevelFromUserDefaults() -> Int {
        if let sharedDefaults = UserDefaults(suiteName: "group.com.container.IronDiary") {
            return sharedDefaults.integer(forKey: "sharedFillLevel")
        } else {
            return -1
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), ironProgress: readFillLevelFromUserDefaults(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), ironProgress: readFillLevelFromUserDefaults(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, ironProgress: readFillLevelFromUserDefaults(), configuration: configuration)
        entries.append(entry)
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var ironProgress: Int
    let configuration: ConfigurationAppIntent
}

struct IronDiaryWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {

            Image(systemName: "bolt.heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 45)
                .foregroundColor(Color(red: 0.9137, green: 0.3059, blue: 0.3059))
                .widgetAccentable()
                .opacity(0.8)
            Spacer(minLength: 20)
            VStack {
                HStack {
                    Text("Iron Diary")
                        .bold()
                    Spacer()
                }
                HStack {
                    Text("\(entry.ironProgress)")
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.9137, green: 0.3059, blue: 0.3059))
                        .widgetAccentable()
                    Text("/")
                    Text("\(entry.configuration.ironDailyGoal)")
                    Text("mg")
                        .font(.system(size: 15))
                    Spacer()
                }
                .bold()
                Spacer()
            }
            .frame(height: 45)
        }
    }
    
}



@main
struct IronDiaryWidget: Widget {
    let kind: String = "IronDiaryWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            IronDiaryWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.ironProgress = 2
        intent.ironDailyGoal = 18
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.ironProgress = 1
        intent.ironDailyGoal = 18
        return intent
    }
}

#Preview(as: .accessoryRectangular) {
    IronDiaryWidget()
} timeline: {
    SimpleEntry(date: .now, ironProgress: 1, configuration: .smiley)
    SimpleEntry(date: .now, ironProgress: 2, configuration: .starEyes)
}
