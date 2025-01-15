//
//  AppViewModel.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//

import Foundation
import Combine
import GRDB
import GoogleMaps
import BottomSheet



@MainActor
final class MainViewModel: ObservableObject{
    //Stores the database, only accessable by the viewmodel
    private let database: HistoricalSiteDatabase
    
    //Values that are fetched from the database
    //@Published var allHistoricalSites: [HistoricalSite] = []
    
    @Published var siteMarkers: [GMSMarker] = []
    @Published var currentSite: HistoricalSite
    @Published var displayState: SiteDisplayState = SiteDisplayState.FullMap
    @Published var sitePhotos: [SitePhotos] = []
    @Published var siteSources: [SiteSource] = []
    @Published var siteTypes: [String] = []
    @Published var bottomSheetPercent: BottomSheetPosition = .hidden
    
    //Lets the map know when a new marker is selected
    //Used in searchBar
    @Published var selectedMarker: GMSMarker?
    //Informes the map that the newly selected site was selected by the search bar
    @Published var siteSelectedBySearch: Bool = false
    
    
    
    
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
                marker.snippet = site.formatedAddress()
                marker.userData = site.id
                
                
                
                //Resizes the icon
                let markerIcon = MapIconFormatting.resizeImage(
                    //loads image based off of main type
                    image: UIImage(named: MapIconFormatting.getTypeMarkerString(typeId: site.mainType))!,
                    scaledToSize: CGSize(width: 55, height: 55))
                
                
                marker.icon = markerIcon
                
                return marker
            }
        }
    }
    
    //Called by ContentView to show the legend bottom sheet
    func showLegendSheet() {
        displayState = SiteDisplayState.MapWithLegend
        bottomSheetPercent = .relative(SiteDisplayState.MapWithLegend.rawValue)
    }
    
    //Called when a new site is selected
    func newSiteSelected(newSiteId: Int) {
        //Hide the legend sheet if it is open
        bottomSheetPercent = .hidden
        
        //Get the site information
        if newSiteId != currentSite.id {
            
            //Clears the fetched info from the last selected site
            self.siteTypes = []
            self.sitePhotos = []
            self.siteSources = []
            
            //Get the site by the siteId
            //And fetch the related info for the site from the SitePhotos, SiteSources, and SiteWithType
            do {
                
                try self.database.reader.read{ db in
                    //Site
                    if let newSite = try HistoricalSite.filter(Column("id") == newSiteId).fetchOne(db){
                        self.currentSite = newSite
                    }
                    
                    
                    //Photos
                    self.sitePhotos = try SitePhotos.filter(Column("siteId") == newSiteId).fetchAll(db)
                    
                    //Sources
                    self.siteSources = try SiteSource.filter(Column("siteId") == newSiteId).fetchAll(db)
                    //Replaced sources from string to the siteSource object, as that as a ID we can use in the foreach loop
//                    let sourcesSQL = "SELECT info FROM siteSource where siteId = ?"
//                    self.siteSources = try String.fetchAll(db, sql:
//                                                            sourcesSQL, arguments:[ newSite.id]  )
                    
                    //Site Types
                    let siteTypesSQL = "SELECT type FROM siteType INNER JOIN siteWithType ON siteWithType.siteTypeId = siteType.id WHERE siteWithType.siteId = ?"
                    
                    self.siteTypes = try String.fetchAll(db, sql: siteTypesSQL, arguments: [newSiteId])
                    
                }
            } catch {
                let nsError = error as NSError
                print("MainViewModel.newSiteSelected.Error Fetching extra site info: \(nsError.localizedDescription)")
                
            }
        }
        
        //Lastly set the display state
        displayState = SiteDisplayState.HalfSite
    }
    
    
    
    
    
    
    
    
    
    
}
