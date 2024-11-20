//
//  AppViewModel.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//

import Foundation
import Combine
import GRDB
import GRDBQuery

final class AppViewModel: ObservableObject{
    //Stores the database, only accessable by the viewmodel
    private let database: HistoricalSiteDatabase
    
    //Values that are fetched from the database
    @Published var allHistoricalSites: [HistoricalSite]
    
    
    @Published var currentSite: HistoricalSite
    
    init( database: HistoricalSiteDatabase) {
        self.currentSite = HistoricalSite()
        self.database = database
        //let rows = HistoricalSite.fetchAll(database)
        self.allHistoricalSites = []
    }
}
