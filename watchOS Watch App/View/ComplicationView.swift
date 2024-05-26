//
//  ComplicationView.swift
//  watchOS Watch App
//
//  Created by Jennifer Luvindi on 26/05/24.
//

import ClockKit
import SwiftUI

struct ComplicationView: View {
    var fillLevel: Int
    var dailyIronGoal: Int
    
    var body: some View {
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
                .frame(width: 30)
        }
    }
    
    private func fillHeight(for totalHeight: CGFloat) -> CGFloat {
        return totalHeight * ((CGFloat(dailyIronGoal) - CGFloat(fillLevel)) / CGFloat(dailyIronGoal))
    }
}

struct ComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ComplicationView(fillLevel: 1, dailyIronGoal: 18)
            CLKComplicationTemplateGraphicCornerCircularView(
                ComplicationView(fillLevel: 1, dailyIronGoal: 18)
            )
            .previewContext()

        }
    }
}
