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
    var sourceList: [String]
    
    
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
                        if site.description != nil{
                            DisplayDescriptionView(
                                description: site.description!)
                            .padding(paddingBetweenItems)
                        }
                        
                        DisplaySiteSourcesView(sourcesList: sourceList)
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


#Preview {
    let photo1 = SitePhotos(id: 140229, siteId: 3817, photoName: "3817_oddfellowshome2_1715023463.jpg", width: 600, height: 422, photoUrl: "http://www.mhs.mb.ca/docs/sites/images/oddfellowshome2.jpg",
                           info: "<strong>Architect’s drawing of the Odd Fellows Home</strong> (1922)<br/><a href=\"http://www.mhs.mb.ca/docs/business/freepress.shtml\">Manitoba Free Press</a>, 15 July 1922, page 48.",                           importDate: "2024-05-06 14:24:23"
                           )
    
    let photo2 = SitePhotos(id: 140229, siteId: 3817, photoName: "3817_oddfellowshome2_1715023463.jpg", width: 600, height: 250, photoUrl: "http://www.mhs.mb.ca/docs/sites/images/oddfellowshome2.jpg",
                           info: "<strong>Architect’s drawing of the Odd Fellows Home</strong> (1922)<br/><a href=\"http://www.mhs.mb.ca/docs/business/freepress.shtml\">Manitoba Free Press</a>, 15 July 1922, page 48.",                           importDate: "2024-05-06 14:24:23"
                           )
    
    let sources = ["<a href=\"http://www.gov.mb.ca/chc/hrb/mun/m053.html\" target=\"_blank\">St. Andrews United Church, NE4-13-6 EPM Garson</a>, Manitoba Historic Resources Branch.",
                   "<em>One Hundred Years in the History of the Rural Schools of Manitoba: Their Formation, Reorganization and Dissolution (1871-1971)</em> by <a href=\"http://www.mhs.mb.ca/docs/people/perfect_mb.shtml\">Mary B. Perfect</a>, MEd thesis, University of Manitoba, April 1978."
                   
    ]
    
    @State var displayState = SiteDisplayState.FullSite
    
    
    DisplaySiteInfoView(
        site: HistoricalSite(),
        displayState: $displayState ,
        siteTypes: [],
        userLocation: CLLocationCoordinate2D(latitude: 49.8555522, longitude: -97.2878815),
        sitePhotos: [photo1, photo2],
        sourceList: sources
        
    )
}
