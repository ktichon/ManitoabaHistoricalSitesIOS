//
//  SitePhotos.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB

struct SitePhotos : Codable, Hashable, Sendable, FetchableRecord, TableRecord{
    var id: Int
    
    var siteId: Int
    
    
    var photoName: String
    
    var width: Int
    var height: Int
    
    
    var photoUrl: String
    
    var info: String?
    
    var importDate: String
}
