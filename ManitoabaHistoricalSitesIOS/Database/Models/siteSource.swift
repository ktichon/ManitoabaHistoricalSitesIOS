//
//  siteSource.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB

struct SiteSource : Codable, Hashable, Sendable, FetchableRecord, TableRecord{
    var id: Int
    var siteId: Int
    var info: String
    var importDate: String
}
