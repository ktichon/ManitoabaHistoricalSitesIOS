//
//  FormatHTML.swift
//  IOS_App_Previewing
//
//  Created by Kyle Tichon on 2024-12-19.
//

import Foundation
import SwiftUI
import CoreLocation
class SiteInfoFormatting {
    
    //Gets the site name from the main type
    static func getTypeName(typeId: Int) -> String{
        let siteTypeMapping = [
            //1 is featured site, and no site has that as a main type
            1: "Featured Site",
            //2 is Museum or Archives
            2 : "Museum or Archives",
            //3 is Building
            3 : "Building",
            //4 is Monument
            4 : "Monument",
            //5 is Cemetery
            5 : "Cemetery",
            //6 is Location
            6 : "Location",
            //7 is Other
            7 : "Other"
            
        ]
        if let typeName = siteTypeMapping[typeId]{
            return typeName
        } else{
            return "Error getting site type"
        }
    }
    
    
    
    //turns CLLocationCoordinate2D into CLLocation
    static func turnCoordinateToLocation(coord: CLLocationCoordinate2D) -> CLLocation{
        return CLLocation(latitude: coord.latitude, longitude: coord.longitude)
    }
    
    //Gets distance in meters between two CLLocationCoordinate2Ds
    static func getDistanceInMeters(coord1: CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> Double{
        
        //First turn the CLLocationCoordinate2Ds intoCLLocations
        let location1 = turnCoordinateToLocation(coord: coord1)
        let location2 = turnCoordinateToLocation(coord: coord2)
        
        //Then call the distance method
        return location1.distance(from: location2)
    }
    
    //Formats the distance from the user location into a string
    static func getDisplayDistance(coord1: CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> String{
        let distanceInMeters = getDistanceInMeters(coord1: coord1, coord2: coord2)
        
        //When meters is less than 1 km
        var displayDistance :String = "\(Int(distanceInMeters)) m"
        
        //When meters is greater than 100 km, round to km
        if distanceInMeters > 100000 {
            displayDistance = "\(Int(distanceInMeters/1000)) km"
        }
        //When meters is greater than 10 km, round to 1 decimal
        else if distanceInMeters > 10000{
            displayDistance = String(format: "%.1f km", (distanceInMeters/1000))
        }
        //When meters is greater than 1 km, round to 2 decimals
        else if distanceInMeters >= 1000{
            displayDistance = String(format: "%.2f km", (distanceInMeters/1000))
        }
        
        return "\(displayDistance) away"
        

    }
    
   
    
}

// Extentiong that turns string into AttributedString
extension StringProtocol {
    func htmlToAttributedString() throws -> AttributedString {
        try .init(
            .init(
                data: .init(utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        )
    }
}

