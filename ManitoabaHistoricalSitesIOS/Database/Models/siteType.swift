//
//  siteType.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB

struct SiteType : Codable, Hashable, Sendable{
    var id: Int
    var type: String
    var importDate: String
    
}

