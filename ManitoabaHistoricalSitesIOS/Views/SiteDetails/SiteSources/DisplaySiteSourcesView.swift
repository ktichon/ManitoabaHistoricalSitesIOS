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
                    //Text(html: source.infoMarkdown, font: .body)
                    Text(LocalizedStringKey(source.infoMarkdown))
                        .font(.body)
                        .padding(sourcePadding)
                }
                
            }
            //Text("This info was last updated imported from the MHS to this app on  ")
            
            
            
        }
    }
}


