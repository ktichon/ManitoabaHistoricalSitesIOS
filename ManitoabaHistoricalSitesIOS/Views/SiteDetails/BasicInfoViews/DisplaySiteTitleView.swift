//
//  DisplaySiteTitleView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-12.
//


//
//  DisplaySiteTitleView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-11.
//

import SwiftUI

struct DisplaySiteTitleView: View {
    //will bind later
    @Binding var displayState: SiteDisplayState
    var name: String
    var paddingBetweenItems: CGFloat = 10
    var body: some View {
        
        //default align items to center
        HStack(alignment: .center){
            
            let lineLimit = (displayState == SiteDisplayState.HalfSite ? 2 : 10)
            Text(name)
                .bold()
                .lineLimit(lineLimit)
                .font(.title)
                .textSelection(.enabled)
            
            //Insures that text is aligned to left edge
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Button{
                displayState = SiteDisplayState.FullMap
            } label: {
                Image(systemName: "xmark")
                    //.fontWeight(.bold)
                    .font(.system(size: 50))
                    .padding(5)
                    .foregroundStyle(Color.primary)
                //Insures that the close button aligns to the top
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            
                
            
            
                
            
        }
        //half as much padding vertically as opposed to horizontaly
        .padding(EdgeInsets(top: paddingBetweenItems / 2, leading: paddingBetweenItems, bottom: paddingBetweenItems / 2, trailing: paddingBetweenItems))
        //uses a fixed size so I can get the close button to always align to top
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.primary, lineWidth: 5)
        )
        .contentShape(Rectangle())
        
        //Toggles displayState between HalfSite and FullSite when clicked
        .onTapGesture {
            if (displayState == SiteDisplayState.HalfSite){
                displayState = SiteDisplayState.FullSite
            } else{
                displayState = SiteDisplayState.HalfSite
            }
        }
        
            
        
    }
}

var longName:String = "Ebenezer Evangelical Lutheran Church / Bethel African Methodist Episcopal Church / First Norwegian Baptist Church / German Full Gospel Church / Indian Metis Holiness Chapel / Vietnamese Mennonite Church"

var shortName: String = "Odd Fellows Home"

#Preview("Long Name Half") {
    
    @State var displayState: SiteDisplayState = SiteDisplayState.HalfSite
    return DisplaySiteTitleView(displayState: $displayState, name: longName
    )
}

#Preview("Long Name Full") {
    
    @State var displayState: SiteDisplayState = SiteDisplayState.FullSite
    return DisplaySiteTitleView(displayState: $displayState, name: longName
    )
}


#Preview("Short Name Half") {
    
    @State var displayState: SiteDisplayState = SiteDisplayState.HalfSite
    return DisplaySiteTitleView(displayState: $displayState, name: shortName
    )
}

#Preview("Short Name Full") {
    
    @State var displayState: SiteDisplayState = SiteDisplayState.FullSite
    return DisplaySiteTitleView(displayState: $displayState, name: shortName
    )
}

