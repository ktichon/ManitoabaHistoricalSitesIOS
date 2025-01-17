//
//  MarkerExtention.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2025-01-15.
//

import Foundation
import GoogleMaps

//Extend the GMSMarker class to get the name and address in one string that we can then use for searching
extension GMSMarker {
    var getNameAndAddress: String {
        return "\(self.title ?? ""), \(self.snippet ?? "")"}
}
