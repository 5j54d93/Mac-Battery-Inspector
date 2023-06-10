//
//  AppleSmartBatteryHelper.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/19.
//

import Foundation
import SwiftUI

class AppleSmartBatteryHelper: ObservableObject {
    
    @Published var currentCapacity: Int?
    @Published var timeRemaining: Int?
    @Published var appleRawAdapterDetails: NSMutableArray?
    @Published var designCycleCount9C: Int?
    @Published var maxCapacity: Int?
    @Published var temperature: Int?
    @Published var avgTimeToEmpty: Int?
    @Published var isCharging: Bool? {
        didSet {
            if oldValue != isCharging {
                if isCharging == true {
                    batteryImagePrimaryColor = Color(red: 254/255, green: 215/255, blue: 9/255)
                    batteryImageSecondaryColor = Color.green
                    batteryImageName = "bolt.ring.closed"
                    isAnimated = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        self.isAnimated = false
                        self.isShowAdapter = true
                        self.batteryImageSecondaryColor = Color.gray
                        self.updateBatteryImage()
                        self.layout = AnyLayout(VStackLayout(spacing: 30))
                    }
                } else {
                    isShowAdapter = false
                    layout = AnyLayout(HStackLayout(alignment: .center, spacing: 30))
                    updateBatteryImage()
                }
            }
        }
    }
    @Published var cycleCount: Int?
    
    @Published var isAnimated = false
    @Published var isShowAdapter = false
    @Published var batteryImageName = "battery.0"
    @Published var batteryImagePrimaryColor = Color.white
    @Published var batteryImageSecondaryColor = Color.gray
    @Published var layout = AnyLayout(HStackLayout(alignment: .center, spacing: 30))
    
    let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceNameMatching("AppleSmartBattery"))
    
    init() {
        getData()
        updateBatteryImage()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.spring().speed(0.8)) {
                    self.getData()
                }
            }
        }
    }
    
    func updateBatteryImage() {
        if isCharging == true {
            batteryImageName = "battery.100.bolt"
            batteryImagePrimaryColor = Color.white
        } else if let currentCapacity = currentCapacity {
            if currentCapacity >= 90 {
                batteryImageName = "battery.100"
                batteryImagePrimaryColor = Color.white
            } else if currentCapacity >= 75 {
                batteryImageName = "battery.75"
                batteryImagePrimaryColor = Color.white
            } else if currentCapacity >= 50 {
                batteryImageName = "battery.50"
                batteryImagePrimaryColor = Color("Battery30Color")
            } else if currentCapacity >= 25 {
                batteryImageName = "battery.25"
                batteryImagePrimaryColor = Color("Battery30Color")
            } else if currentCapacity >= 0 {
                batteryImageName = "battery.0"
                batteryImagePrimaryColor = Color("Battery0Color")
            }
        }
    }
    
    func getData() {
        isCharging = getRegistryProperty(forKey: .IsCharging) as? Bool
        currentCapacity = getRegistryProperty(forKey: .CurrentCapacity) as? Int
        timeRemaining = getRegistryProperty(forKey: .TimeRemaining) as? Int
        appleRawAdapterDetails = getRegistryProperty(forKey: .AppleRawAdapterDetails) as? NSMutableArray
        designCycleCount9C = getRegistryProperty(forKey: .DesignCycleCount9C) as? Int
        maxCapacity = getRegistryProperty(forKey: .MaxCapacity) as? Int
        temperature = getRegistryProperty(forKey: .Temperature) as? Int
        avgTimeToEmpty = getRegistryProperty(forKey: .AvgTimeToEmpty) as? Int
        cycleCount = getRegistryProperty(forKey: .CycleCount) as? Int
    }
    
    func getRegistryProperty(forKey key: AppleSmartBatteryKeyType) -> Any? {
        IORegistryEntryCreateCFProperty(service, key.rawValue as CFString?, nil, 0).takeRetainedValue()
    }
}
