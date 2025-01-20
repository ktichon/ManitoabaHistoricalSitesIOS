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
            //Moved all this into its own view DisplayNoPhotosView
//            if sitePhotos.isEmpty{
//               
//                
//                Text("We have no photos for this site. If you have one in your personal collection and can provide a copy, please contact us at photos@mhs.mb.ca")
//                    .font(.title3)
//                    .multilineTextAlignment(.center)
                
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


