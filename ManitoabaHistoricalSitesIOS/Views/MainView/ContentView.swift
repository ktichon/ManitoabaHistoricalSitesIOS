//
//  ContentView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//

import SwiftUI
import GoogleMaps
import GRDB

struct ContentView: View {
    
    @ObservedObject private var mainViewModel : MainViewModel
    @StateObject private var locationManager = LocationManager()
    
    
    @State private var searchText = ""
    @State private var searchIsActive = false
    

    

    init(database : HistoricalSiteDatabase) {
        _mainViewModel = ObservedObject(wrappedValue: MainViewModel(database: database))
        
    }
    
    var body: some View {
        NavigationStack{
            VStack {
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
                                siteSelectedBySearch: mainViewModel.siteSelectedBySearch,
                                newSiteSelected: mainViewModel.newSiteSelected
                            )
                            
                            
                            
                            
                            //Show site info
                            if (mainViewModel.displayState == SiteDisplayState.FullSite  || mainViewModel.displayState == SiteDisplayState.HalfSite){
                                
                                DisplaySiteInfoView(
                                    site: mainViewModel.currentSite,
                                    displayState: $mainViewModel.displayState,
                                    siteTypes: mainViewModel.siteTypes,
                                    userLocation: locationManager.lastKnownLocation,
                                    sitePhotos: mainViewModel.sitePhotos,
                                    siteTables: mainViewModel.siteTables,
                                    sourceList: mainViewModel.siteSources)
                                .frame(height: displayedItemSize)
                                //Sets the background colour to default
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                
                            }
                            
                            //Button to show legend
                            if(mainViewModel.displayState == SiteDisplayState.FullMap){
                                
                                NavigationLink(destination: LegendView()){
                                    Text("Legend")
                                        .foregroundStyle(Color.primary)
                                        .font(.title3.bold())
                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                        .background(
                                            Capsule()
                                                .strokeBorder(Color.primary, lineWidth: 1)
                                                 .background(Capsule().fill(Color(UIColor.tertiarySystemBackground)))
                                        )
                                        .navigationTitle("Back")
                                }
                                .padding(5)
                                
                            }
                            
                            if mainViewModel.searchActive{
                                DisplaySearchResults(
                                    searchResults: mainViewModel.searchedSiteList,
                                    userLocation: locationManager.lastKnownLocation,
                                    newSiteSelected: mainViewModel.newSiteSelected(siteMarker:selectedBySearch:),
                                    searchActive: $mainViewModel.searchActive)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                            }
                        }
                    }
        
                }
                    
                
                
            }
            .padding([.top], 10)
            
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    if !mainViewModel.siteMarkers.isEmpty{
                        CustomSearchBar(
                            searchText: $mainViewModel.searchQuery,
                            searchActive: $mainViewModel.searchActive
                        )
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing){
                    
                    if mainViewModel.searchActive {
                        Button{
                            mainViewModel.searchActive.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(Color.accentColor)
                                .font(.system(size: 25))
                        }
                        
                    } else {
                        Menu{
                            NavigationLink(destination: AboutView()){
                                Text("About")
                        }
                            
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                        }
                    }
                    
                }
                
            }
            
        }
       
        
    }
}
    
#Preview {
    AppView().historicalSiteDatabase(.empty())
    
}
