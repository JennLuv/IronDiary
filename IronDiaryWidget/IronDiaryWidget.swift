//
//  IronDiaryWidget.swift
//  IronDiaryWidget
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import WidgetKit
import SwiftUI
import HealthKit

struct Provider: AppIntentTimelineProvider {
    let ironProgress: Int
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), ironProgress: ironProgress, configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), ironProgress: ironProgress, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, ironProgress: ironProgress, configuration: configuration)
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
    @EnvironmentObject var healthStore: HealthStore
    var entry: Provider.Entry
    @Binding var ironProgress: Int
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "bolt.heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 45)
                .foregroundColor(Color(red: 0.9137, green: 0.3059, blue: 0.3059))
                .opacity(0.8)
            Spacer(minLength: 20)
            VStack {
                HStack {
                    Text("Iron Diary")
                        .bold()
                    Spacer()
                }
                HStack {
                    Text("\(ironProgress)") // Update to use ironProgress state
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.9137, green: 0.3059, blue: 0.3059))
                    Text("/")
                    Text("\(entry.configuration.ironDailyGoal)")
                    Text("mg")
                    Spacer()
                }
                .bold()
                Spacer()
            }
            .frame(height: 45)
        }
        .onAppear {
            updateIronProgress()
        }
        .environmentObject(healthStore)
    }
    func updateIronProgress() {
        healthStore.fetchTotalIronConsumedToday { totalIron in
            ironProgress = Int(totalIron)
        }
    }
}
        
        
        
        @main
        struct IronDiaryWidget: Widget {
            let kind: String = "IronDiaryWidget"
            @State private var ironProgress: Int = 0
            let healthStore = HealthStore() // Initialize healthStore directly
            
            var body: some WidgetConfiguration {
                AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider(ironProgress: 0)) { entry in
                    IronDiaryWidgetEntryView(entry: entry, ironProgress: $ironProgress)
                        .containerBackground(.fill.tertiary, for: .widget)
                        .onAppear {
                            healthStore.requestAuthorization()
                        }
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
