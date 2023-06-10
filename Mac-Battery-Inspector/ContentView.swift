//
//  ContentView.swift
//  Mac-Battery-Inspector
//
//  Created by 00592272 on 2023/5/18.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appleSmartBatteryHelper: AppleSmartBatteryHelper
    @ObservedObject var powerSourcesHelper: PowerSourcesHelper
    
    @State private var selectionValue = SidebarType.HighLight
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selectionValue: $selectionValue)
                .frame(width: 155)
        } detail: {
            switch selectionValue {
            case .HighLight:
                HighlightView(appleSmartBatteryHelper: appleSmartBatteryHelper, powerSourcesHelper: powerSourcesHelper)
            case .ScreenSaver:
                ScreenSaverView(appleSmartBatteryHelper: appleSmartBatteryHelper)
            case .RowData:
                RowDataView(appleSmartBatteryHelper: appleSmartBatteryHelper, powerSourcesHelper: powerSourcesHelper)
            }
        }
        .toolbar(id: "Toolbar") {
            ToolbarView()
        }
    }
}
