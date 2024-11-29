//
//  ContentView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//

import SwiftUI
import GRDB
import GRDBQuery

struct ContentView: View {
    
    @ObservedObject private var mainViewModel : MainViewModel
    

    init(database : HistoricalSiteDatabase) {
        _mainViewModel = ObservedObject(wrappedValue: MainViewModel(database: database))
    }
    
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
            
            if mainViewModel.siteMarkers.isEmpty {
                Text("Loading Sites using the ViewModel")
            } else {
                MapViewControllerBridge(siteMarkers: $mainViewModel.siteMarkers)
//                Text("Found \(mainViewModel.allHistoricalSites.count) Historical Sites using ViewModel!")
            }
            
            
            
        }
        .padding()

    }
}

#Preview {
    AppView().historicalSiteDatabase(.empty())
    
}
