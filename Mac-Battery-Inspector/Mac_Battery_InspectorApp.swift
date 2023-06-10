//
//  Mac_Battery_InspectorApp.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/18.
//

import SwiftUI

@main
struct Mac_Battery_InspectorApp: App {
    
    @StateObject private var appleSmartBatteryHelper = AppleSmartBatteryHelper()
    @StateObject private var powerSourcesHelper = PowerSourcesHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView(appleSmartBatteryHelper: appleSmartBatteryHelper, powerSourcesHelper: powerSourcesHelper)
                .frame(minWidth: 780, minHeight: 520)
        }
        .windowToolbarStyle(.unifiedCompact)
        .commands {
            MenuCommand()
        }
        
        Window("About Mac Battery Inspector", id: "About") {
            AboutView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        
        Settings {
            SettingsView()
        }
        
        MenuBarExtra {
            MenuBarExtraView(appleSmartBatteryHelper: appleSmartBatteryHelper)
        } label: {
            Image(systemName: appleSmartBatteryHelper.isCharging ?? false ? "bolt.square.fill" : "minus.plus.batteryblock.fill")
                .resizable()
                .scaledToFit()
        }
        .menuBarExtraStyle(.window)
    }
}
