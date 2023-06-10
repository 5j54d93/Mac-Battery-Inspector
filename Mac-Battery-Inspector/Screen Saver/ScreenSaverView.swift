//
//  ScreenSaverView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/20.
//

import SwiftUI

struct ScreenSaverView: View {
    
    @ObservedObject var appleSmartBatteryHelper: AppleSmartBatteryHelper
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            LazyHGrid(rows: Array(repeating: GridItem(spacing: 10), count: 10), spacing: 10) {
                ForEach(1..<101) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("CardBorderColor"))
                        .frame(width: (geo.size.width - 90) / 10)
                        .background {
                            rectangleForegroundColor(index: index)
                                .cornerRadius(5)
                        }
                }
            }
        }
        .padding()
        .navigationTitle("Screen Saver")
        .background(Color("BackgroundColor"))
    }
    
    func rectangleForegroundColor(index: Int) -> Color {
        let currentCapacity = appleSmartBatteryHelper.currentCapacity ?? 100
        if index <= currentCapacity {
            if index >= 71 {
                return Color("Battery70Color")
            } else if index >= 31 {
                return Color("Battery30Color")
            } else {
                return Color("Battery0Color")
            }
        } else {
            return Color("CardColor")
        }
    }
}
