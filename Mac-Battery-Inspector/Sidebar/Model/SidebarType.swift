//
//  SidebarType.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/19.
//

import Foundation

enum SidebarType {
    case HighLight, ScreenSaver, RowData
    
    var title: String {
        switch self {
        case .HighLight: return "High Light"
        case .ScreenSaver: return "Screen Saver"
        case .RowData: return "Row Data"
        }
    }
    
    var imageName: String {
        switch self {
        case .HighLight: return "bolt.square.fill"
        case .ScreenSaver: return "square.inset.filled"
        case .RowData: return "square.fill.text.grid.1x2"
        }
    }
}
