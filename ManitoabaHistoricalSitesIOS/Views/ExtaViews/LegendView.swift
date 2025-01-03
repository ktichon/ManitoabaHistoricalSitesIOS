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
    private let flexibleColumn = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        VStack{
//            Text("Legend")
//                .font(.title2)
           
            LazyVGrid(columns: flexibleColumn, spacing: 10){
                ForEach(siteTypeId, id: \.self){ siteType in
                    HStack(){
                        Image(
                            uiImage: MapIconFormatting.resizeImage(
                            //loads image based off of main type
                                image: UIImage(named: MapIconFormatting.getTypeMarkerString(typeId: siteType))!,
                            scaledToSize: CGSize(width: 55, height: 55))
                        )
                        
                        Text(SiteInfoFormatting.getTypeName(typeId: siteType))
                        Spacer()
                        
                        
                    }
                    
                }
            
            }
        }
        
        
        
        
        
    }
}

#Preview {
    LegendView()
}
