//
//  DisplaySiteLinkView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-19.
//

import SwiftUI

struct DisplaySiteLinkView: View {
    var url: String
    
    var body: some View {
        if let notNullURl = URL(string: url) {
            Link("Click here to go to the Manitoba Historical Society webpage for this site!", destination: notNullURl)
                .font(.title3)
        }
        
        
    }
}

#Preview {
    DisplaySiteLinkView(url : "http://www.mhs.mb.ca/docs/sites/oddfellowshome.shtml")
}
