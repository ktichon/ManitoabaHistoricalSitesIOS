//
//  DisplaySiteBasicInfo.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-12.
//

import SwiftUI

struct DisplaySiteAddressInfoView: View {
    var siteTypes: [String]
    var fullAddress: String
    var distanceFromUser: String
    var body: some View {
        VStack(alignment: .leading){
            Text("\(siteTypes.joined(separator: "/")), \(distanceFromUser)" )
                .font(.body)
            Text(fullAddress)
                .font(.body)
        }.textSelection(.enabled)
    }
}

#Preview {
    DisplaySiteAddressInfoView(
        siteTypes: ["Building", "Museum or Archives"], fullAddress: "333 Alexander Avenue, Winnipeg", distanceFromUser: "100 km away"
    )
}
