//
//  RowDataView.swift
//  Mac Battery Inspector
//
//  Created by 00592272 on 2023/5/19.
//

import SwiftUI

struct RowDataView: View {
    
    @ObservedObject var appleSmartBatteryHelper: AppleSmartBatteryHelper
    @ObservedObject var powerSourcesHelper: PowerSourcesHelper
    
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                if !powerSourcesHelper.powerSource.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Power Sources Info")
                            .font(.title2.bold())
                        
                        if searchText.isEmpty {
                            ForEach(powerSourcesHelper.powerSource, id: \.key) { item in
                                RowDataItemView(searchText: $searchText, title: item.key, description: item.value)
                            }
                        } else if powerSourcesHelper.powerSource.filter({ $0.key.lowercased().contains(searchText.lowercased()) }).isEmpty {
                            SearchNonView(searchText: $searchText)
                        } else {
                            ForEach(powerSourcesHelper.powerSource.filter({ $0.key.lowercased().contains(searchText.lowercased()) }), id: \.key) { item in
                                RowDataItemView(searchText: $searchText, title: item.key, description: item.value)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Apple Smart Battery")
                        .font(.title2.bold())
                    
                    if searchText.isEmpty {
                        ForEach(AppleSmartBatteryKeyType.allCases, id: \.self) { item in
                            RowDataItemView(searchText: $searchText, title: item.rawValue, description: appleSmartBatteryHelper.getRegistryProperty(forKey: item))
                        }
                    } else if AppleSmartBatteryKeyType.allCases.filter({ $0.rawValue.lowercased().contains(searchText.lowercased()) }).isEmpty {
                        SearchNonView(searchText: $searchText)
                    } else {
                        ForEach(AppleSmartBatteryKeyType.allCases.filter({ $0.rawValue.lowercased().contains(searchText.lowercased()) }), id: \.self) { item in
                            RowDataItemView(searchText: $searchText, title: item.rawValue, description: appleSmartBatteryHelper.getRegistryProperty(forKey: item))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Row Data")
        .searchable(text: $searchText)
        .background(Color("BackgroundColor"))
    }
}

struct RowDataItemView: View {
    
    @Binding var searchText: String
    
    let title: String
    var description: Any?
    
    var body: some View {
        HStack {
            Group {
                if let searchTextRange = title.range(of: searchText, options: .caseInsensitive) {
                    Text(title.prefix(upTo: searchTextRange.lowerBound))
                    +
                    Text(title[searchTextRange])
                        .foregroundColor(Color("Battery70Color"))
                    +
                    Text(title.suffix(from: searchTextRange.upperBound))
                } else {
                    Text(title)
                }
            }
            .font(.title3.bold())
            
            Spacer()
            
            if let description {
                Text(String(describing: description))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("CardColor"))
        }
    }
}

struct SearchNonView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image(systemName: "rectangle.and.text.magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            Text("Your search\n- \(searchText) -\ndid not match any property.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .fixedSize()
        }
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity)
        .padding()
    }
}
