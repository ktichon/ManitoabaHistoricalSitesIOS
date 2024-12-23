//
//  MapIconFormating.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-23.
//

import Foundation
import SwiftUI
import CoreLocation

class MapIconFormatting {
    
    //Gets the name for the marker icon associated with the main type
    static func getTypeMarkerString(typeId: Int) -> String{
        let siteTypeMapping = [
            //1 is featured site, and no site has that as a main type
            1: "site_marker",
            //2 is Museum or Archives
            2 : "site_marker_museum",
            //3 is Building
            3 : "site_marker_building",
            //4 is Monument
            4 : "site_marker_monument",
            //5 is Cemetery
            5 : "site_marker_cemetery",
            //6 is Location
            6 : "site_marker_location",
            //7 is Other
            7 : "site_marker_other"
            
        ]
        if let typeColour = siteTypeMapping[typeId]{
            return typeColour
        } else{
            return "site_marker"
        }
    }
    
    //Resizes an UIImage
    static func resizeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
