//
//  HistoricalSiteDatabase+SwiftUI.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-19.
//

import Foundation
import GRDBQuery
import SwiftUI

//Don't need the rest of this, as it is only for writing to the database
//defining a RepositoryKey that grants access to the database
//private struct HistoricalSiteDatabaseKey: EnvironmentKey{
//    static let defaultValue = HistoricalSiteDatabase.empty()
//}
//
//extension EnvironmentValues {
//    fileprivate(set) var historicalSiteDatabase: HistoricalSiteDatabase{
//        get {self[HistoricalSiteDatabaseKey.self]}
//        set {self[HistoricalSiteDatabaseKey.self]}
//    }
//}

extension View {
    //Sets the databaseContext for @Query environment values
    func historicalSiteDatabase(_ database: HistoricalSiteDatabase) -> some View {
        self
            // For if I wanted to write to the database
            //.environment(\.historicalSiteDatabase, database)
        
            // A read only connection to the database
            .databaseContext(.readOnly{database.reader})
    }
    
}
