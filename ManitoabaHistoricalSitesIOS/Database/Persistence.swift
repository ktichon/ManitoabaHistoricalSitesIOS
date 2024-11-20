//
//  Persistence.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-13.
//

import Foundation
import GRDB


//Instansiation of the database that is used in my view model
extension HistoricalSiteDatabase {
    //the database for the application
    static let shared = makeShared()
    
    private static func makeShared() -> HistoricalSiteDatabase{
        do{
            //gets the resourse from the database
            let dbPath = Bundle.main.path(forResource: "db", ofType: "sqlite")
            
            // Writes are disallowed because resources can not be modified
            var config = Configuration()
            config.readonly = true
                
            let dbQueue = try DatabaseQueue(path: dbPath!, configuration: config)
            let historicalSiteDatabase = try HistoricalSiteDatabase(dbQueue)
            return historicalSiteDatabase
            
        } catch {
            //Will replace with good error handling later
            fatalError("Unresolved error \(error)")
        }
    }
    
    static func empty() -> HistoricalSiteDatabase{
        try! HistoricalSiteDatabase(DatabaseQueue( configuration: HistoricalSiteDatabase.makeConfiguration()))
    }
}


