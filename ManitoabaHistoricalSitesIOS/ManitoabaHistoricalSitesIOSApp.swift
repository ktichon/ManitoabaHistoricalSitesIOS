//
//  ManitoabaHistoricalSitesIOSApp.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-04.
//

import SwiftUI

@main
struct ManitoabaHistoricalSitesIOSApp: App {
    //Gets the Map API key before loading the map
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .historicalSiteDatabase(.shared)
        }
    }
}
