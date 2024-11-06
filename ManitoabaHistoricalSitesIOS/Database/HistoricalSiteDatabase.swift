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
    init(_ dbWriter: any GRDB.DatabaseWriter) {
        self.dbWriter = dbWriter
    }
    
    
    //DatabaseMigrator defines the database schema
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        
        //Deletes the database when migrations change, speeds up development
#if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
#endif
        migrator.registerMigration("v1"){ db in
            //Declaring Tables
            try db.create(table: "manitobaHistoricalSite"){ t in
                t.primaryKey("site_id", .integer).notNull()
                t.column("name", .text).notNull()
                t.column("address", .text)
                t.column("main_type", .integer).notNull()
                t.column("latitude", .real).notNull()
                t.column("longitude", .real).notNull()
                t.column("province", .text)
                t.column("municipality", .text)
                t.column("description", .text)
                t.column("site_url", .text).notNull()
                t.column("keywords", .text)
                t.column("import_date", .text).notNull()
            }
            
            try db.create(table: "sitePhotos"){ t in
                t.primaryKey("photo_id", .integer).notNull()
                t.column("site_id", .integer).notNull()
                t.column("photo_name", .text).notNull()
                t.column("width", .integer).notNull()
                t.column("height", .integer).notNull()
                t.column("photo_url", .text).notNull()
                t.column("info", .text)
                t.column("import_date", .text).notNull()
            }
            
            try db.create(table: "siteSource"){ t in
                t.primaryKey("source_id", .integer).notNull()
                t.column("site_id", .integer).notNull()
                t.column("info", .text).notNull()
                t.column("import_date", .text).notNull()
            }
            
            try db.create(table: "siteWithType"){ t in
                t.primaryKey("site_with_type_id", .integer).notNull()
                t.column("site_type_id", .integer).notNull()
                t.column("site_id", .integer).notNull()
                t.column("import_date", .text).notNull()
                
            }
            
            try db.create(table: "siteType"){ t in
                t.primaryKey("site_type_id", .integer).notNull()
                t.column("type", .text).notNull()
                t.column("import_date", .text).notNull()
            }
            
        }
        
        
        //Migrations for future app version are put here, in the same format as above
        
        return migrator
    }
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

