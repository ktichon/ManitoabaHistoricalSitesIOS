//
//  Queries.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//

import Foundation
import GRDB
import GRDBQuery

struct HistoricalSiteRequest: FetchQueryable   {
    static let queryableOptions: QueryableOptions = QueryableOptions.async
    
    static var defaultValue: [HistoricalSite] { []}
    
    func fetch(_ db: Database) throws -> [HistoricalSite] {
        try HistoricalSite.fetchAll(db)
    }

}

