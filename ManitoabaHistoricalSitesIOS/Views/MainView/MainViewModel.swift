//
//  AppViewModel.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//

import Foundation
import Combine
import GRDB
import GRDBQuery
import GoogleMaps



@MainActor
final class MainViewModel: ObservableObject{
    //Stores the database, only accessable by the viewmodel
    private let database: HistoricalSiteDatabase
    
    //Values that are fetched from the database
    //@Published var allHistoricalSites: [HistoricalSite] = []
    
    @Published var siteMarkers: [GMSMarker] = []
    @Published var currentSite: HistoricalSite
    @Published var displayState: SiteDisplayState = SiteDisplayState.FullMap
    
    
    
    
    init( database: HistoricalSiteDatabase) {
        //Sets the property values
        self.currentSite = HistoricalSite()
        self.database = database
        //let rows = HistoricalSite.fetchAll(database)
        
        
        //Seperated the fetching of data and the setting of markers.
        setSiteMarkers(sites: getAllHistroicalSites())        
    }
    
    //Gets all the sites from the database
    func getAllHistroicalSites() -> [HistoricalSite] {
        var allHistoricalSites : [HistoricalSite] =  []
        do {
             allHistoricalSites = try self.database.reader.read{ db in
                try HistoricalSite.fetchAll(db)
    
            }
        } catch {
            let nsError = error as NSError
            print("MainViewModel.getAllHistoricalSites.Error loading database: \(nsError.localizedDescription)")
        }
        
        return allHistoricalSites
    }
    
    
    //turns a list of sites into markers used on the app
    func setSiteMarkers(sites : [HistoricalSite]) ->  Void{
        if sites.isEmpty{
            print("MainViewModel.setSiteMarkers.No Sites Found")
        } else {
            //Creates a marker for each site and adds them to the list
            siteMarkers = sites.map{ site in
                let marker = GMSMarker(position: site.position)
                marker.title = site.name
                marker.userData = site
                marker.snippet = site.formatedAddress()
                return marker
            }
        }
    }
    
    func newSiteSelected(newSite: HistoricalSite) {
        if newSite != currentSite {
            currentSite = newSite
            displayState = SiteDisplayState.HalfSite
        }        
    }
    
    
    
    
    
    
    
}
