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
            AsyncImage(url: URL(string: photo.photoUrl)){ phase in
                switch phase {
                
                case .failure(_):
                    Image(systemName: "photo.badge.exclamationmark").resizable()
                case .success(let image):
                    //Opens link to image in browser on click
                    Link(destination: URL(string: photo.photoUrl)!){
                        image.resizable()
                    }
                    
                default:
                    Image(systemName: "photo").resizable()
                
                }
            }
            .padding(5)
            .frame(
                width: CGFloat(photo.width / 2),
                height: CGFloat(photo.height / 2))
            
            //shrink the photo to be half of the normal size
                
//            Image(systemName: "exclamationmark.octagon")
            
            if let photoInfo = photo.infoMarkdown{
                //Text(SiteInfoFormatting.renderHTML(html: photo.info!, font: .body))
                //Text(html: photoInfo, font: .body)
                Text(LocalizedStringKey(photoInfo))
                    .font(.body)
                    .padding([.trailing, .leading], 10)
                    .multilineTextAlignment(.center)
                    
            }
            
            HStack{
                Spacer()
                Text("\(photoIndex)/\(totalNumberOfPhotos)")
                    .font(.body)
            }
            
            
            
        } .padding(10)
    }
}


