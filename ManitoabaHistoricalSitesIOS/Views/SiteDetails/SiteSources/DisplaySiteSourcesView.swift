//
//  DisplaySiteSourcesView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-20.
//

import SwiftUI

struct DisplaySiteSourcesView: View {
    var sourcesList : [SiteSource]
    
    let sourcePadding = EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
    var body: some View {
        VStack(alignment: .leading){
            Text("Sources:")
                .font(.title3)
            
        
            
            if(sourcesList.isEmpty){
                Text("There is no additional information about the sources used for this site")
                    .font(.body)
                    .padding(sourcePadding)
            } else{
                ForEach(sourcesList, id: \.id){ source in
                    //Text(SiteInfoFormatting.renderHTML(html: source.info, font: .body))
                    Text(html: source.info, font: .body)
                        .padding(sourcePadding)
                }
                
            }
            //Text("This info was last updated imported from the MHS to this app on  ")
            
            
            
        }
    }
}

#Preview {
    let sources = [
        SiteSource(id: 1, siteId: 1, info: "<a href=\"http://www.gov.mb.ca/chc/hrb/mun/m053.html\" target=\"_blank\">St. Andrews United Church, NE4-13-6 EPM Garson</a>, Manitoba Historic Resources Branch."
                   , importDate: "1/1/2025"),
        SiteSource(id: 2, siteId: 1, info: "<em>One Hundred Years in the History of the Rural Schools of Manitoba: Their Formation, Reorganization and Dissolution (1871-1971)</em> by <a href=\"http://www.mhs.mb.ca/docs/people/perfect_mb.shtml\">Mary B. Perfect</a>, MEd thesis, University of Manitoba, April 1978.", importDate: "1/1/2025")
                   
    ]
    DisplaySiteSourcesView(
        sourcesList: sources
    )
}
