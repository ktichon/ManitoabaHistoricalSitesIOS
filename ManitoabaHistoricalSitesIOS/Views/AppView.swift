//
//  AppView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-20.
//
import GRDB
import GRDBQuery
import SwiftUI

struct AppView: View {
    
    @Query(HistoricalSiteRequest())
    private var allHistoricalSitesTest : [HistoricalSite]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Text("Found \(allHistoricalSitesTest.count) Historical Sites!")
            
        }
        .padding()

    }
}

#Preview {
    AppView()
}
