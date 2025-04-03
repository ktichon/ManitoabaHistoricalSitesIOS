//
//  SiteTable.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-04-01.
//

import Foundation
import GRDB

struct SiteTable : Codable, Hashable, Sendable, FetchableRecord, TableRecord{
    var id: Int
    var siteId: Int
    var name: String?
    var numOfColumns: Int
    var contentHTML: String
    var contentMarkdown: String
    var importDate: String
}
