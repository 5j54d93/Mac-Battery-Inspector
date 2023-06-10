//
//  MenuCommand.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/20.
//

import SwiftUI

struct MenuCommand: Commands {
    
    @Environment(\.openWindow) var openWindow
    
    @AppStorage("preferredColorScheme") var preferredColorScheme = ""
    
    var body: some Commands {
        SidebarCommands()
        ToolbarCommands()
        
        CommandGroup(replacing: .appInfo) {
            Button("About Mac Battery Inspector") {
                openWindow(id: "About")
            }
        }
        
        CommandGroup(replacing: .help) {
            Button("View GitHub Repository") {
                NSWorkspace.shared.open(URL(string: "https://github.com/5j54d93")!)
            }
            .keyboardShortcut("G", modifiers: [.command, .shift])
        }
        
        CommandMenu("Display") {
            Picker("Appearance", selection: $preferredColorScheme) {
                Text("Auto")
                    .tag("")
                
                Text("Light")
                    .tag("light")
                
                Text("Dark")
                    .tag("dark")
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
        }
    }
}
