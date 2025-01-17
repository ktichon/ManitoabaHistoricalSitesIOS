//
//  ContentView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//

import SwiftUI
import GRDB
import BottomSheet

struct ContentView: View {
    
    @ObservedObject private var mainViewModel : MainViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var bottomSheetPercent : BottomSheetPosition = .hidden
    @State private var searchText: String = ""
    

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
                        
                        
                        
                        MapViewControllerBridge(
                            siteMarkers: $mainViewModel.siteMarkers,
                            locationEnable: $locationManager.locationEnabled,
                            newMapLoad: $locationManager.newMapLoad,
                            mapBottomPadding: displayedItemSize,
                            selectedMarker: $mainViewModel.selectedMarker,
                            siteSelectedBySearch: $mainViewModel.siteSelectedBySearch,
                            newSiteSelected: mainViewModel.newSiteSelected(newSiteId: )                            
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
                        
                        //Button to show legend
                        if(mainViewModel.displayState == SiteDisplayState.FullMap){
                            Button{
                                mainViewModel.showLegendSheet()
                            } label: {
                                Text("Legend")
                                    .foregroundStyle(Color.primary)
                                    .font(.title3.bold())
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .background(
                                        Capsule()
                                            .strokeBorder(Color.primary, lineWidth: 1)
                                            .background(Capsule().fill(Color(UIColor.tertiarySystemBackground)))
                                            
                                        
                                    )
                                    
                            }
                            .padding(5)
                            
                
                            //.tint(Color(UIColor.secondarySystemGroupedBackground))
//                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//                            .buttonStyle(.bordered)
//                            .buttonBorderShape( .capsule)
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    .bottomSheet(bottomSheetPosition: $mainViewModel.bottomSheetPercent, switchablePositions: [.relative(SiteDisplayState.MapWithLegend.rawValue), .hidden],
                                 headerContent: {
                        
                        Spacer()
                        Text("Legend")
                            .font(.title2)
                            .bold()
                            .padding([.trailing, .leading])
                        Spacer()
                        
                    }
                                 
                        ){
                        LegendView()
                    }
                    //.isResizable(false)
                    .enableTapToDismiss(true)
                    .showCloseButton(true)
                    .enableSwipeToDismiss(true)
                    .onDismiss {
                        mainViewModel.displayState = .FullMap
                    }
                }
                
                
//                Text("Found \(mainViewModel.allHistoricalSites.count) Historical Sites using ViewModel!")
            }
            
            
            
        }
//        .toolbar{
//            ToolbarItem(placement: .principal){
//                
//            }
//        }

    }
}

#Preview {
    AppView().historicalSiteDatabase(.empty())
    
}
