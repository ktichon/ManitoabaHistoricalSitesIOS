//
//  historicalSite.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB
import CoreLocation

struct HistoricalSite: Codable, Hashable, Sendable, FetchableRecord, PersistableRecord, TableRecord{

    
    var id: Int
    var name: String

    var address: String?

    var mainType: Int
    private var latitude: CLLocationDegrees
    private var longitude: CLLocationDegrees

    var municipality: String?
    var province: String?
    var descriptionHTML: String?
    var descriptionMarkdown: String?

    var siteUrl: String

    var keywords: String?

    var importDate: String
    
    var position: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    //Formated version of the address that adds a comma between the municipality and the address if the address is not null
    func formatedAddress() -> String {
        var formattedAddress = ""
        if let hasAddress = address{
            if !hasAddress.isEmpty{
                formattedAddress = "\(hasAddress), "
            }
            
        }
        return formattedAddress + (municipality ?? "")
    }
    
    public init()  {
        self.id = 0
        self.name = ""
        self.address = ""
        self.mainType = 1
        self.latitude = 49.9000253
        self.longitude = -97.1386276
        self.municipality = ""
        self.province = ""
        self.descriptionHTML = ""
        self.descriptionMarkdown = ""
        self.siteUrl = ""
        self.keywords = ""
        self.importDate = ""
    }
}


