//
//  siteWithType.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB

struct SiteWithType : Codable, Hashable, Sendable{
    var id: Int
    var siteTypeId: Int

    var siteId: Int

    var importDate: String
}
