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
    
    //Lets the map know when a new marker is selected
    //Used in searchBar
    @Published var selectedMarker: GMSMarker?
    //Informes the map that the newly selected site was selected by the search bar
    @Published var siteSelectedBySearch: Bool = false
    
    //Search query
    @Published var searchQuery:String = "" {
        //When a new search value is set, filter list
        didSet{
            if !(textIsBlank(text: searchQuery)){
                searchedSiteList = siteMarkers.filter{ $0.getNameAndAddress.uppercased().contains(searchQuery.uppercased())
                }
            }
        }
    }
    
    @Published var searchActive: Bool = false {
        didSet{
            //If the search text is blank, get default list
            if searchActive && textIsBlank(text: searchQuery){
                searchedSiteList = Array(siteMarkers.prefix(20))
            }
            
            if !searchActive{
                //Hides the keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                searchQuery = ""
            }
        }
    }
    
    @Published var searchedSiteList: [GMSMarker] = []
    
    
    
    
    
    
    
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
    
    
    
    //Called when a new site is selected
    func newSiteSelected(siteMarker: GMSMarker, selectedBySearch: Bool) {
        //Get the newSiteID from the marker
        if let newSiteId = siteMarker.userData as? Int {
            //Lets the map know whether or not the site marker was clicked on, allowing it to zoom in appropriately
            self.siteSelectedBySearch = selectedBySearch
            //Calls an update to the mapViewControllerBridge that will hide the marker info window
            self.selectedMarker = siteMarker
            
            
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
    
   
    
    //Helper function to see if a string is blank or empty
    private func textIsBlank(text: String) -> Bool {
        if text.isEmpty{
            return true
        }
        return text.trimmingCharacters(in: .whitespacesAndNewlines ) == ""
    }
    
}
