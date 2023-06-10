//
//  SidebarView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/18.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var selectionValue: SidebarType
    
    var body: some View {
        List(selection: $selectionValue) {
            Section("Mode") {
                Label(SidebarType.HighLight.title, systemImage: SidebarType.HighLight.imageName)
                    .font(.title3)
                    .padding(.leading, 5)
                    .tag(SidebarType.HighLight)
                
                Label(SidebarType.ScreenSaver.title, systemImage: SidebarType.ScreenSaver.imageName)
                    .font(.title3)
                    .padding(.leading, 5)
                    .tag(SidebarType.ScreenSaver)
            }
            
            Section("More") {
                Label(SidebarType.RowData.title, systemImage: SidebarType.RowData.imageName)
                    .font(.title3)
                    .padding(.leading, 5)
                    .tag(SidebarType.RowData)
            }
        }
        
        HStack(alignment: .bottom) {
            Link(destination: URL(string: "https://github.com/5j54d93")!) {
                Image("GitHub")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .onHover { isOnMouseOver in
                isOnMouseOver ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
            
            Spacer()
            
            Text("v1.0.0")
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}
