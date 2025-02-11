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
                    Divider()
                        .background(Color.secondary)
                    DisplaySearchResult(
                        siteName: siteMarker.title ?? "",
                        siteAddress: siteMarker.snippet ?? "",
                        distanceFromUser: SiteInfoFormatting.getDisplayDistance(coord1: siteMarker.position, coord2: userLocation))
                    
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        newSiteSelected(siteMarker, true)
                        searchActive = false
                        
                    }
                    
                }
                
            }
                
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
                //Bolds text for IOS 15
                Text("**\(siteName)**")
                    .lineLimit(2)
                    .font(.body)
                    // .bold only works for IOS 16 or newer
                    //.bold()
                    .multilineTextAlignment(.leading)
                
                
                Text(siteAddress)
                    .lineLimit(1)
                    .font(.callout)
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
