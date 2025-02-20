//
//  NoDataView.swift
//  watchOS
//
//  Created by Jennifer Luvindi on 20/02/25.
//
import SwiftUI

struct NoDataView: View {
    
    var body: some View {
        VStack{
            Text("Start by consuming an ingredient!")
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            
            Image("NoConsumption")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
        }
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}

