//
//  AboutView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/22.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(spacing: 10) {
            Image(nsImage: NSApplication.shared.applicationIconImage)

            Text(Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Mac Battery Inspector")
                .font(.headline)

            Text("Version " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))

            Button("GitHub") {
                openURL(URL(string: "https://github.com/5j54d93")!)
            }

            Text(verbatim: "Copyright © 2023–\(Calendar.current.component(.year, from: Date())) Ricky Chuang")

            Text("All right reserved.")
        }
        .frame(width: 300, height: 300)
        .background(VisualEffectView().ignoresSafeArea())
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        return NSVisualEffectView()
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) { }
}
