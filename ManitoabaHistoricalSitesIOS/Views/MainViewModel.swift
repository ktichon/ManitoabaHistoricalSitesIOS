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
    @Published var allHistoricalSites: [HistoricalSite] = []
    
    @Published var siteMarkers: [GMSMarker] = []
    
    
    @Published var currentSite: HistoricalSite
    
    init( database: HistoricalSiteDatabase) {
        self.currentSite = HistoricalSite()
        self.database = database
        //let rows = HistoricalSite.fetchAll(database)
        
        getAllHistroicalSites()
        setAllSiteMarkers()
        
        
        
    }
    
    
    func getAllHistroicalSites() -> Void {
        do {
            self.allHistoricalSites = try self.database.reader.read{ db in
                try HistoricalSite.fetchAll(db)
            
            }
        } catch {
            let nsError = error as NSError
            print("MainViewModel.getAllHistoricalSites.Error loading database: \(nsError.localizedDescription)")
        }
    }
    
    func setAllSiteMarkers() ->  Void{
        siteMarkers = allHistoricalSites.map{ site in
            let marker = GMSMarker(position: site.position)
            marker.title = site.name
            marker.userData = site
            //Currently using the site url for testing, will use address in future
            //marker.snippet = site.formatedAddress()
            marker.snippet = site.siteUrl
            return marker
        }
    }
    
    
}
