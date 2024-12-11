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
    @StateObject private var locationManager = LocationManager()
    

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
                Text("Loading Sites ...")
            } else {
                GeometryReader { geometry in
                    //Gets item size using the % of the displayState value and the screen height
                    var displayedItemSize =  (mainViewModel.displayState.rawValue * geometry.size.height)
                    ZStack{
                        
                        
                        
                        MapViewControllerBridge(siteMarkers: $mainViewModel.siteMarkers, locationEnable: $locationManager.locationEnabled,
                                                newMapLoad: $locationManager.newMapLoad,
                                                mapBottomPadding: displayedItemSize,
                                                newSiteSelected: mainViewModel.newSiteSelected(newSite: )
                        )
                        
                        
                    }
                }
                
                
//                Text("Found \(mainViewModel.allHistoricalSites.count) Historical Sites using ViewModel!")
            }
            
            
            
        }
        .padding()

    }
}

#Preview {
    AppView().historicalSiteDatabase(.empty())
    
}
