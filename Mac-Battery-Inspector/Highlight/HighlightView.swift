//
//  HighlightView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/19.
//

import SwiftUI

struct HighlightView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var appleSmartBatteryHelper: AppleSmartBatteryHelper
    @ObservedObject var powerSourcesHelper: PowerSourcesHelper
    
    @State private var isPresentPopover = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    if let temperature = appleSmartBatteryHelper.temperature {
                        InfoRectangleView(imageName: "thermometer.medium", title: "Temperature", info: String(format: "%.2f", Double(temperature)/100) + " ℃", primary: Color(red: 90/255, green: 200/255, blue: 245/255), secondary: Color("TextColor"))
                    } else {
                        InfoRectangleView(imageName: "thermometer.medium", title: "Temperature", info: "Inspecting...", primary: Color(red: 90/255, green: 200/255, blue: 245/255), secondary: Color("TextColor"))
                    }
                    
                    if let timeRemaining = appleSmartBatteryHelper.timeRemaining, timeRemaining != 65535 {
                        InfoRectangleView(imageName: "clock.badge.checkmark", title: "Time Remaining", info: "\(timeRemaining) minutes", primary: .blue, secondary: Color("TextColor"))
                    } else {
                        InfoRectangleView(imageName: "clock.badge.questionmark", title: "Time Remaining", info: "Calculating...", primary: .blue, secondary: Color("TextColor"))
                    }
                }
                .padding(.horizontal)
                .frame(height: geo.size.height / 4)
                
                HStack(spacing: 15) {
                    if appleSmartBatteryHelper.isShowAdapter {
                        HStack(spacing: 30) {
                            Image(systemName: "cable.connector")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                            
                            if let adapterDetails = appleSmartBatteryHelper.appleRawAdapterDetails,
                               adapterDetails.count > 0,
                               let adapterDetailsDic = adapterDetails[0] as? Dictionary<String, Any> {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Adapter Details")
                                        .bold()
                                        .lineLimit(1)
                                        .font(.system(size: 40))
                                        .minimumScaleFactor(0.7)
                                        .padding(.bottom)
                                    
                                    Group {
                                        if let manufacturer = adapterDetailsDic["Manufacturer"] as? String {
                                            HStack {
                                                Text("Manufacturer：")
                                                Spacer()
                                                Text(manufacturer)
                                            }
                                            Divider()
                                        }
                                        if let name = adapterDetailsDic["Name"] as? String {
                                            HStack {
                                                Text("Name：")
                                                Spacer()
                                                Text(name)
                                                    .minimumScaleFactor(0.65)
                                            }
                                            Divider()
                                        }
                                        if let isWireless = adapterDetailsDic["IsWireless"] as? Bool {
                                            HStack {
                                                Text("Is Wireless：")
                                                Spacer()
                                                Text("\(isWireless ? "True" : "False")")
                                            }
                                            Divider()
                                        }
                                        if let watts = adapterDetailsDic["Watts"] as? Int {
                                            HStack {
                                                Text("Watts：")
                                                Spacer()
                                                Text("\(watts) W")
                                            }
                                            Divider()
                                        }
                                    }
                                    .lineLimit(1)
                                    .font(.title)
                                }
                            } else {
                                Text("Inspecting...")
                                    .lineLimit(1)
                                    .font(.system(size: 300))
                                    .minimumScaleFactor(0.01)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(width: geo.size.width * 0.6)
                        .frame(maxHeight: .infinity)
                        .padding(30)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("CardColor"))
                        }
                    }
                    
                    appleSmartBatteryHelper.layout {
                        VStack(spacing: 5) {
                            Image(systemName: appleSmartBatteryHelper.batteryImageName)
                                .resizable()
                                .scaledToFit()
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(appleSmartBatteryHelper.batteryImagePrimaryColor, appleSmartBatteryHelper.batteryImageSecondaryColor, .green)
                                .environment(\.layoutDirection, .leftToRight)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .scaleEffect(1, anchor: .leading)
                                .animation(.spring(), value: appleSmartBatteryHelper.isAnimated)
                            
                            if appleSmartBatteryHelper.isAnimated {
                                Text("Start Charging")
                                    .lineLimit(1)
                                    .font(.system(size: 300))
                                    .minimumScaleFactor(0.01)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .scaleEffect(1, anchor: .leading)
                                    .animation(.spring(), value: appleSmartBatteryHelper.isAnimated)
                            }
                        }
                        
                        if let currentCapacity = appleSmartBatteryHelper.currentCapacity {
                            Text(" \(currentCapacity) ％")
                                .lineLimit(1)
                                .font(.system(size: 300))
                                .minimumScaleFactor(0.01)
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.scaleEffect(appleSmartBatteryHelper.isAnimated ? 0.6 : 1, anchor: .trailing)
                                .animation(.spring(), value: appleSmartBatteryHelper.isAnimated)
                                .contextMenu {
                                    Button("About Current Capacity") { isPresentPopover = true }
                                        .keyboardShortcut("P", modifiers: .command)
                                    Button("Demo contextMenu") { isPresentPopover = true }
                                    Divider()
                                    Button("Demo contextMenu") { isPresentPopover = true }
                                }
                                .popover(isPresented: $isPresentPopover) {
                                    VStack(alignment: .leading) {
                                        Text("Current Capacity")
                                            .font(.title2.bold())
                                        
                                        Divider()
                                        
                                        Text("Apple-defined power sources will publish this key in units of percent. The value is usually 100%.")
                                        
                                        Divider()
                                        
                                        Button("Search on Google") {
                                            NSWorkspace.shared.open(URL(string: "https://www.google.com/search?q=Current Capacity".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
                                        }
                                    }
                                    .frame(width: 350, height: 300, alignment: .top)
                                    .padding()
                                }
                        } else {
                            Text("Inspecting ％")
                                .lineLimit(1)
                                .font(.system(size: 300))
                                .minimumScaleFactor(0.01)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .environment(\.layoutDirection, appleSmartBatteryHelper.isShowAdapter ? .rightToLeft : .leftToRight)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(30)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("CardColor"))
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    if let designCycleCount9C = appleSmartBatteryHelper.designCycleCount9C,
                       let cycleCount = appleSmartBatteryHelper.cycleCount {
                        InfoRectangleView(imageName: "clock.arrow.2.circlepath", title: "Cycle Count", info: "\(cycleCount)／\(designCycleCount9C) times", primary: .orange, secondary: Color("TextColor"))
                    } else {
                        InfoRectangleView(imageName: "clock.arrow.2.circlepath", title: "Cycle Count", info: "Inspecting...", primary: .orange, secondary: Color("TextColor"))
                    }
                    
                    if let BatteryHealth = powerSourcesHelper.powerSource.first(where: { $0.key == "BatteryHealth" })?.value as? String {
                        InfoRectangleView(imageName: "bolt.shield\(colorScheme == .light ? ".fill" : "")", title: "Battery Health", info: BatteryHealth, primary: Color(red: 254/255, green: 215/255, blue: 9/255), secondary: Color("TextColor"))
                    } else {
                        InfoRectangleView(imageName: "bolt.shield\(colorScheme == .light ? ".fill" : "")", title: "Battery Health", info: "Calculating...", primary: .yellow, secondary: Color("TextColor"))
                    }
                }
                .padding(.horizontal)
                .frame(height: geo.size.height / 4)
            }
        }
        .navigationTitle("Highlight")
        .background(Color("BackgroundColor"))
    }
}

struct InfoRectangleView: View {
    
    let imageName: String
    let title: String
    let info: String
    let primary: Color
    let secondary: Color
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(primary, secondary)
                    .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.6)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Spacer(minLength: 0)
                    
                    Text(title)
                        .bold()
                        .padding(.bottom, 5)
                    
                    Spacer(minLength: 0)
                    
                    Text(info)
                    
                    Spacer(minLength: 0)
                }
                .lineLimit(1)
                .font(.system(size: 40))
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("CardColor"))
            }
        }
        .padding(.vertical)
    }
}
