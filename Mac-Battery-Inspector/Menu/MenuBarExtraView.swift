//
//  MenuBarExtraView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/21.
//

import SwiftUI

struct MenuBarExtraView: View {
    
    @ObservedObject var appleSmartBatteryHelper: AppleSmartBatteryHelper
    
    @State private var foregroundColor = Color.primary
    @State private var backgroundColor = Color.clear
    
    var body: some View {
        VStack {
            Text("Mac Battery Inspector")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            GroupBox {
                HStack {
                    if let timeRemaining = appleSmartBatteryHelper.timeRemaining, timeRemaining != 65535 {
                        Label("Time Remaining", systemImage: "clock.badge.checkmark")
                    } else {
                        Label("Time Remaining", systemImage: "clock.badge.questionmark")
                    }
                    
                    Spacer()
                    
                    if let timeRemaining = appleSmartBatteryHelper.timeRemaining, timeRemaining != 65535 {
                        Text("\(timeRemaining) minutes")
                    } else {
                        Text("Calculating...")
                    }
                }
                .padding(5)
                
                HStack {
                    Label("Temperature", systemImage: "thermometer.medium")
                    
                    Spacer()
                    
                    if let temperature = appleSmartBatteryHelper.temperature {
                        Text(String(format: "%.2f", Double(temperature)/100) + " ℃")
                    } else {
                        Text("Inspecting...")
                    }
                }
                .padding(5)
                
                HStack {
                    Label("Cycle Count", systemImage: "clock.arrow.2.circlepath")
                    
                    Spacer()
                    
                    if let designCycleCount9C = appleSmartBatteryHelper.designCycleCount9C,
                       let cycleCount = appleSmartBatteryHelper.cycleCount {
                        Text("\(cycleCount)／\(designCycleCount9C) times")
                    } else {
                        Text("Inspecting...")
                    }
                }
                .padding(5)
            }
            
            Divider()
        }
        .padding([.top, .horizontal], 10)
        
        Text("Open Mac Battery Inspector...")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
            .padding(.top, 2)
            .padding(.bottom, 5)
            .foregroundColor(foregroundColor)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(backgroundColor)
            }
            .onHover { isOnMouseOver in
                foregroundColor = isOnMouseOver ? .white : Color.primary
                backgroundColor = isOnMouseOver ? Color(red: 75/255, green: 154/255, blue: 253/255) : .clear
            }
            .onTapGesture {
                NSApplication.shared.activate(ignoringOtherApps: true)
                NSApplication.shared.windows.first?.makeKeyAndOrderFront(self)
                NSApplication.shared.windows.first?.setIsVisible(true)
            }
            .padding([.horizontal, .bottom], 5)
    }
}
