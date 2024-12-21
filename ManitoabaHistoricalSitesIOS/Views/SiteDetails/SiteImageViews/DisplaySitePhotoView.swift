//
//  DisplaySitePhotoView.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-20.
//

import SwiftUI

struct DisplaySitePhotoView: View {
    var photo: SitePhotos
    var photoIndex: Int
    var totalNumberOfPhotos: Int
    var body: some View {
        VStack{
            
            Image(systemName: "photo").resizable()
            //shrink the photo to be half of the normal size
                .frame(
                    width: CGFloat(photo.width / 2),
                    height: CGFloat(photo.height / 2))
//            Image(systemName: "exclamationmark.octagon")
            
            if photo.info != nil{
                //If the device is unable to run the nice pager, we have to set a fixed size
                if #available(iOS 17.0, *) {
                    Text(SiteInfoFormatting.renderHTML(html: photo.info!, font: .body))
                        .padding([.trailing, .leading], 10)
                        .multilineTextAlignment(.center)
                } else {
                    Text(SiteInfoFormatting.renderHTML(html: photo.info!, font: .body))
                        //.padding([.trailing, .leading], 10)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(
                            maxWidth: (CGFloat(photo.width / 2) + 20)
                        
                        )
                        
                }
                
                    
            }
            
            HStack{
                Spacer()
                Text("\(photoIndex)/\(totalNumberOfPhotos)")
                    .font(.body)
            }
            
            
            
        }
    }
}

#Preview {
    let photo = SitePhotos(id: 140229, siteId: 3817, photoName: "3817_oddfellowshome2_1715023463.jpg", width: 600, height: 422, photoUrl: "http://www.mhs.mb.ca/docs/sites/images/oddfellowshome2.jpg",
                           info: "<strong>Architect’s drawing of the Odd Fellows Home</strong> (1922)<br/><a href=\"http://www.mhs.mb.ca/docs/business/freepress.shtml\">Manitoba Free Press</a>, 15 July 1922, page 48.",                           importDate: "2024-05-06 14:24:23"
                           )
    DisplaySitePhotoView(
        photo: photo,
        photoIndex: 1,
        totalNumberOfPhotos: 3
    )
}
