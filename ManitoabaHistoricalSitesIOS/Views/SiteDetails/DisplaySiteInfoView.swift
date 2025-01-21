//
//  DisplaySiteInfo.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-19.
//

import SwiftUI
import CoreLocation

struct DisplaySiteInfoView: View {
    var site : HistoricalSite
    @Binding var displayState: SiteDisplayState
    var siteTypes: [String]
    var userLocation: CLLocationCoordinate2D
    var sitePhotos: [SitePhotos]
    var sourceList: [SiteSource]
    
    
    let paddingBetweenItems = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
    
    //Used to determine who the top view in a scrollView is
    private static let topScrollID = "topView"
    var body: some View {
        VStack{
            DisplaySiteTitleView(displayState: $displayState, name: site.name, paddingBetweenItems:  paddingBetweenItems)
                
                
            ScrollViewReader{ scroll in
                ScrollView{
                    VStack(alignment: .leading){
                        
                        DisplaySiteAddressInfoView(
                            //If the siteType array is empty, then use the site.mainType
                            siteTypes: (
                                (siteTypes.isEmpty ?
                                 [SiteInfoFormatting.getTypeName(typeId: site.mainType)] :
                                    siteTypes)
                                ),
                            fullAddress: site.formatedAddress(),
                            distanceFromUser: SiteInfoFormatting.getDisplayDistance(coord1: site.position, coord2: userLocation)
                        )
                        .padding(paddingBetweenItems)
                        .id(Self.topScrollID)
                        
                        
                        if sitePhotos.isEmpty{
                            DisplayNoPhotosView()
                                .padding(paddingBetweenItems)
                        } else {
                            DisplaySitePhotosView(
                                sitePhotos: sitePhotos)
                            .padding(paddingBetweenItems)
                        }
                        
                        
                        
                        
                        //Only display description if it is not null
                        if let siteDescription = site.descriptionMarkdown{
                            DisplayDescriptionView(
                                description: siteDescription)
                            .padding(paddingBetweenItems)
                        }
                        
                        DisplaySiteSourcesView(sourcesList: sourceList)
                            .padding(paddingBetweenItems)
                        
                        DisplaySiteImportDateView(importDate: site.importDate)
                            .padding(paddingBetweenItems)
                            
                        
                        DisplaySiteLinkView(
                            url: site.siteUrl)
                        .padding(paddingBetweenItems)
                    }
                    .onChange(of: site){_ in
                        scroll.scrollTo(Self.topScrollID, anchor: .top)
                    }
                }
                
            }
            
            
            
        }
    }
}


