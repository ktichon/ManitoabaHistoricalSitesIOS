//
//  AboutView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-04-01.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Text("About")
                .font(.title)
            Text("Welcome to my app! History has always been a passion of mine, and I quite excited to combine it with my love of coding.\n\nI started working on this app in October 2022, displaying all Historical Sites according to the [City of Winnipeg Open Data](https://data.winnipeg.ca/City-Planning/Historical-Resources/ptpx-kgiu). With the data from the City of Winnipeg, I was able to display around 720 sites. While I was excited by what I was able to accomplish, the Winnipeg data was limited in what it could display. I knew that I could do more.\n\nA year after starting this project, I contact the [Manitoba Historical Society](https://www.mhs.mb.ca) about creating an app for them. It took another year to get an grant, and was able to send out the first alpha test in January 2025. With the support of the MHS, I was successful in extracting 99% of the data from thier website, and now this app displays over 9600 historic sites all across Manitoba!\n\nThank you Manitoba Historical Society for providing all the information used in this app.\n\nCreated by me, Kyle Tichon.")
                .padding(.horizontal, 20)
            Spacer()
        }
        
    }
}

#Preview {
    AboutView()
}
