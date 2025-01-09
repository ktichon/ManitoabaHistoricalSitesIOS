//
//  DisplayNoPhotosView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-09.
//

import SwiftUI

struct DisplayNoPhotosView: View {
    //var siteName: String
    //var siteURL: String
    
    var body: some View {
        VStack{
            //Unable to get opening up the email app to work
//            //Builds the email url
//            let emailTo = "photos@mhs.mb.ca"
//            let emailSubject = "Photos for Site \(siteName)"
//            let emailBody = "This information is used by the Manitoba Historical Society to find the site in question, please do not remove this line from this email. Site URL: \(siteURL) \n\n"
//            let emailURL = URL(string: "mailto:\(emailTo)?subject=\(emailSubject)&body=\(emailBody)")
            
            
            //Link("We have no photos for this site. If you have one in your personal collection and can provide a copy, please contact us at photos@mhs.mb.ca", destination: emailURL!)
            Text("We have no photos for this site. If you have one in your personal collection and can provide a copy, please contact us at photos@mhs.mb.ca")
                .font(.title3)
                .multilineTextAlignment(.center)
        }
    }
        
}

#Preview {
    DisplayNoPhotosView(
        //siteName: "name", siteURL: "url"
    )
}
