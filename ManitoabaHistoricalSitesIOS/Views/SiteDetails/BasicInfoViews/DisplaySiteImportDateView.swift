//
//  DisplaySiteImportDate.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-20.
//

import SwiftUI

struct DisplaySiteImportDateView: View {
    var importDate: String
    var body: some View {
        Text("This information was last imported from the MHS website on \(importDate)")
            .font(.body)
    }
}


