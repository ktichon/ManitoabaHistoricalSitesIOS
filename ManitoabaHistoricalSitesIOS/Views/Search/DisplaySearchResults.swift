//
//  DisplaySearchResults.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-22.
//


import SwiftUI
import CoreLocation
import GoogleMaps

//Displays the list of search results
struct DisplaySearchResults: View {
    var searchResults: [GMSMarker]
    var userLocation: CLLocationCoordinate2D
    var newSiteSelected: (GMSMarker, Bool) -> Void
    @Binding var searchActive: Bool
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(searchResults, id: \.self){ siteMarker in
                    
                    DisplaySearchResult(
                        siteName: siteMarker.title ?? "",
                        siteAddress: siteMarker.snippet ?? "",
                        distanceFromUser: SiteInfoFormatting.getDisplayDistance(coord1: siteMarker.position, coord2: userLocation))
                    
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .onTapGesture {
                        newSiteSelected(siteMarker, true)
                        searchActive = false
                        
                    }
                    Divider()
                        .background(Color.secondary)
                }
                
            }.padding(5)
                
        }
    }
}

//Display used for each search result
struct DisplaySearchResult: View {
    var siteName: String
    var siteAddress: String
    var distanceFromUser: String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(siteName)
                    .lineLimit(2)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                
                Text(siteAddress)
                    .lineLimit(2)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack{
                Text(distanceFromUser)
            }
            .padding(5)
        }
    }
    
}
