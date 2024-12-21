//
//  DisplaySiteSourcesView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-20.
//

import SwiftUI

struct DisplaySiteSourcesView: View {
    var sourcesList : [String]    
    
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
                ForEach(sourcesList, id: \.self){ source in
                    Text(SiteInfoFormatting.renderHTML(html: source))
                        .font(.body)
                        .padding(sourcePadding)
                }
                
            }
            
            
        }
    }
}

#Preview {
    let sources = ["<a href=\"http://www.gov.mb.ca/chc/hrb/mun/m053.html\" target=\"_blank\">St. Andrews United Church, NE4-13-6 EPM Garson</a>, Manitoba Historic Resources Branch.",
                   "<em>One Hundred Years in the History of the Rural Schools of Manitoba: Their Formation, Reorganization and Dissolution (1871-1971)</em> by <a href=\"http://www.mhs.mb.ca/docs/people/perfect_mb.shtml\">Mary B. Perfect</a>, MEd thesis, University of Manitoba, April 1978."
                   
    ]
    DisplaySiteSourcesView(
        sourcesList: sources
    )
}
