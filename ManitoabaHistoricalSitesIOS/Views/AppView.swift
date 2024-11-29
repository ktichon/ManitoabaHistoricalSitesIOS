//
//  AppView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//
import GRDB
import GRDBQuery
import SwiftUI

//View that creates the observable object MainViewModel from the SwiftUI environment
struct AppView: View {
    @Environment(\.historicalSiteDatabase) var database
    
    
    var body: some View {
        ContentView(database: database)
    }
}
