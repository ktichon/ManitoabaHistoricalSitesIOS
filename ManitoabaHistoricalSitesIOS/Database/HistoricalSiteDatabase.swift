//
//  HistoricalSiteDatabase.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-05.
//

import Foundation
import GRDB

final class HistoricalSiteDatabase: Sendable {
    //The object that actually writes and reads the database
    private let dbWriter: any DatabaseWriter
    
    
    //Creates HistoricalSiteDatabase with the dbWriter and the database schema
    init(_ dbWriter: any GRDB.DatabaseWriter)  throws{
        self.dbWriter = dbWriter
        //try migrator.migrate(dbWriter)
    }
    
    
    //Migrator is not necessary, as we are using a read only database
    //DatabaseMigrator defines the database schema
//    private var migrator: DatabaseMigrator {
//        var migrator = DatabaseMigrator()
//        
//        
//        //Deletes the database when migrations change, speeds up development
//#if DEBUG
//        migrator.eraseDatabaseOnSchemaChange = true
//#endif
//        migrator.registerMigration("v1"){ db in
//            //Declaring Tables
//            try db.create(table: "historicalSite"){ t in
//                t.primaryKey("id", .integer).notNull()
//                t.column("name", .text).notNull()
//                t.column("address", .text)
//                t.column("mainType", .integer).notNull()
//                t.column("latitude", .real).notNull()
//                t.column("longitude", .real).notNull()
//                t.column("province", .text)
//                t.column("municipality", .text)
//                t.column("description", .text)
//                t.column("siteUrl", .text).notNull()
//                t.column("keywords", .text)
//                t.column("importDate", .text).notNull()
//            }
//            
//            try db.create(table: "sitePhotos"){ t in
//                t.primaryKey("id", .integer).notNull()
//                t.column("siteId", .integer).notNull()
//                t.column("photoName", .text).notNull()
//                t.column("width", .integer).notNull()
//                t.column("height", .integer).notNull()
//                t.column("photoUrl", .text).notNull()
//                t.column("info", .text)
//                t.column("importDate", .text).notNull()
//            }
//            
//            try db.create(table: "siteSource"){ t in
//                t.primaryKey("id", .integer).notNull()
//                t.column("siteId", .integer).notNull()
//                t.column("info", .text).notNull()
//                t.column("importDate", .text).notNull()
//            }
//            
//            try db.create(table: "siteWithType"){ t in
//                t.primaryKey("id", .integer).notNull()
//                t.column("siteTypeId", .integer).notNull()
//                t.column("siteId", .integer).notNull()
//                t.column("importDate", .text).notNull()
//                
//            }
//            
//            try db.create(table: "siteType"){ t in
//                t.primaryKey("id", .integer).notNull()
//                t.column("type", .text).notNull()
//                t.column("importDate", .text).notNull()
//            }
//            
//        }
//        
//        
//        //Migrations for future app version are put here, in the same format as above
//        
//        return migrator
//    }
}

//Sets the database config
extension HistoricalSiteDatabase {
    //Returns the database configuration for HistoricalSiteDatabase
    static func makeConfiguration(_ config: Configuration = Configuration()) -> Configuration {
        return config
    }
}


//Database Access
extension HistoricalSiteDatabase{
    //Read Access
    var reader: any GRDB.DatabaseReader{
        dbWriter
    }
}

