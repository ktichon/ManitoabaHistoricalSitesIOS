//
//  DisplaySitePhotosView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-20.
//

import SwiftUI

struct DisplaySitePhotosView: View {
    var sitePhotos: [SitePhotos]

    var body: some View {
        VStack{
            if sitePhotos.isEmpty{
                Text("We have no photos for this site. If you have one in your personal collection and can provide a copy, please contact us at photos@mhs.mb.ca")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
            } else {
                //It seems like IOS 17 added a bunch of fancy for scrollviews.
                //Such as easily showing one item per view
                if #available(iOS 17.0, *) {
                    ScrollView(.horizontal){
                        HStack{
                            
                            ForEach(Array(sitePhotos.enumerated()), id: \.offset){ index, photo in
                                DisplaySitePhotoView(
                                    photo: photo,
                                    photoIndex: index + 1,
                                    totalNumberOfPhotos: sitePhotos.count)
                                
                            }
                            //Sets the size to be one photo length
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                        }
                        //enables snap to view
                        //.scrollTargetLayout()
                    }
                    //set that we snap to view
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.never)
                } else {
                    //For all the people not running on ios 17 (like me, with my ios 15 iphone)
                    ScrollView(.horizontal){
                        HStack(spacing: 10){
                            
                            ForEach(Array(sitePhotos.enumerated()), id: \.offset){ index, photo in
                                DisplaySitePhotoView(
                                    photo: photo,
                                    photoIndex: index + 1,
                                    totalNumberOfPhotos: sitePhotos.count)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(
                                    maxWidth: (CGFloat(photo.width / 2) + 20)
                                    
                                
                                
                                )
                                .padding(10)
                               
                            }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview ("With Photos") {
    let photo1 = SitePhotos(id: 140229, siteId: 3817, photoName: "3817_oddfellowshome2_1715023463.jpg", width: 600, height: 422, photoUrl: "http://www.mhs.mb.ca/docs/sites/images/oddfellowshome2.jpg",
                           info: "<strong>Architect’s drawing of the Odd Fellows Home</strong> (1922)<br/><a href=\"http://www.mhs.mb.ca/docs/business/freepress.shtml\">Manitoba Free Press</a>, 15 July 1922, page 48.",                           importDate: "2024-05-06 14:24:23"
                           )
    
    let photo2 = SitePhotos(id: 140229, siteId: 3817, photoName: "3817_oddfellowshome2_1715023463.jpg", width: 600, height: 250, photoUrl: "http://www.mhs.mb.ca/docs/sites/images/oddfellowshome2.jpg",
                           info: "<strong>Architect’s drawing of the Odd Fellows Home</strong> (1922)<br/><a href=\"http://www.mhs.mb.ca/docs/business/freepress.shtml\">Manitoba Free Press</a>, 15 July 1922, page 48.",                           importDate: "2024-05-06 14:24:23"
                           )
    DisplaySitePhotosView(
        sitePhotos: [photo1, photo2]
    )
}

#Preview("No Photos"){
    DisplaySitePhotosView(
        sitePhotos: []
    )
}
