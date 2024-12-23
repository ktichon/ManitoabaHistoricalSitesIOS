//
//  ContentView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//

import SwiftUI
import GRDB

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
                ProgressView("Loading all Historic Sites ...")
            } else {
                GeometryReader { geometry in
                    //Gets item size using the % of the displayState value and the screen height
                    let displayedItemSize =  (mainViewModel.displayState.rawValue * geometry.size.height)
                    ZStack(alignment: .bottom){
                        
                        
                        
                        MapViewControllerBridge(siteMarkers: $mainViewModel.siteMarkers, locationEnable: $locationManager.locationEnabled,
                                                newMapLoad: $locationManager.newMapLoad,
                                                mapBottomPadding: displayedItemSize,
                                                newSiteSelected: mainViewModel.newSiteSelected(newSite: )
                        )
                        
                        //Show site info
                        if (mainViewModel.displayState == SiteDisplayState.FullSite  || mainViewModel.displayState == SiteDisplayState.HalfSite){
                            
                            DisplaySiteInfoView(
                                site: mainViewModel.currentSite,
                                displayState: $mainViewModel.displayState,
                                siteTypes: mainViewModel.siteTypes,
                                userLocation: locationManager.lastKnownLocation,
                                sitePhotos: mainViewModel.sitePhotos,
                                sourceList: mainViewModel.siteSources)
                            .frame(height: displayedItemSize)
                            //Sets the background colour to default
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            
                            
                        
                            
                            
                        }
                        
                        
                        
                        
                    }
                }
                
                
//                Text("Found \(mainViewModel.allHistoricalSites.count) Historical Sites using ViewModel!")
            }
            
            
            
        }

    }
}

#Preview {
    AppView().historicalSiteDatabase(.empty())
    
}
