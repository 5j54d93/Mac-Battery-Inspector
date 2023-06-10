//
//  PowerSourcesHelper.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/19.
//

import Foundation
import IOKit.ps

class PowerSourcesHelper: ObservableObject {
    
    @Published var powerSource: [Dictionary<String, AnyObject>.Element] = []
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.getPowerSource()
            }
        }
    }
    
    func getPowerSource() {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        guard let source = sources.first,
              let powerSource = IOPSGetPowerSourceDescription(snapshot, source).takeUnretainedValue() as? Dictionary<String, AnyObject>
        else { return }
        self.powerSource = powerSource.sorted(by: { $0.key > $1.key })
    }
}
