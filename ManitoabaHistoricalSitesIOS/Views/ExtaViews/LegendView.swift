//
//  LegendView.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-23.
//


//
//  LegendView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-23.
//

import SwiftUI

//The legend that displays in the bottom sheet
struct LegendView: View {
    
    private let siteTypeId = Array( 2 ... 7)
    //private let flexibleColumn = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        VStack{
            Text("Legend")
                .font(.title)
           
            ForEach(siteTypeId, id: \.self){ siteType in
                HStack(){
                    Image(
                        uiImage: MapIconFormatting.resizeImage(
                        //loads image based off of main type
                            image: UIImage(named: MapIconFormatting.getTypeMarkerString(typeId: siteType))!,
                        scaledToSize: CGSize(width: 55, height: 55))
                    )
                    
                    Text(SiteInfoFormatting.getTypeName(typeId: siteType))
                        .font(.title3)
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 20)
                
            }
            Text("Historic Sites of Manitoba, by the [Manitoba Historical Society](https://www.mhs.mb.ca)")
                .font(.title2)
                .padding(.horizontal, 70)
                .padding(.vertical, 100)
                .multilineTextAlignment(.center)
        }
        
        
        
        
        
    }
}

#Preview {
    LegendView()
}
