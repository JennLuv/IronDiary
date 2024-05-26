//
//  ComplicationController.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(
                identifier: "complication",
                displayName: "Iron Tracker",
                supportedFamilies: [.graphicCircular] // Only use the graphic circular template
            )
        ]
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Handle newly shared complication descriptors if needed
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil) // For simplicity, we won't provide future entries
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let template = getTemplate(for: complication.family)
        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        handler(entry)
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = getTemplate(for: complication.family)
        handler(template)
    }
    
    private func getTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate {
        let fillLevel = 10 // Placeholder fill level
        let dailyIronGoal = 18 // Placeholder daily iron goal
        
        let view = ComplicationView(fillLevel: fillLevel, dailyIronGoal: dailyIronGoal)
        
        return CLKComplicationTemplateGraphicCircularView(view)
    }
}
