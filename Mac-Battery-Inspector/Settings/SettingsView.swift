//
//  SettingsView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/21.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("preferredColorScheme") var preferredColorScheme = ""
    
    var body: some View {
        TabView {
            Picker("Appearance：", selection: $preferredColorScheme) {
                Text("System")
                    .tag("")
                
                Text("Light")
                    .tag("light")
                
                Text("Dark")
                    .tag("dark")
            }
            .frame(width: 200)
            .padding()
            .tabItem {
                Image(systemName: "gearshape")
                
                Text("General")
            }
            .onChange(of: preferredColorScheme) { newValue in
                if newValue == "light" {
                    NSApplication.shared.appearance = NSAppearance(named: .aqua)
                } else if newValue == "dark" {
                    NSApplication.shared.appearance = NSAppearance(named: .darkAqua)
                } else {
                    NSApplication.shared.appearance = nil
                }
            }
            
            Text("Latest update：")
                .tabItem {
                    Image(systemName: "arrow.clockwise")
                    
                    Text("Updates")
                }
        }
        .navigationTitle("Settings")
        .frame(width: 400, height: 250)
    }
}
