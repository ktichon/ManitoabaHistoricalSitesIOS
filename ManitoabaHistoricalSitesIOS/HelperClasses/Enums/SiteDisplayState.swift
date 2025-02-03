//
//  SiteDisplayState.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-09.
//

import Foundation
enum SiteDisplayState  : CGFloat {
    //Raw value controlls what percent of the map will be covered (and thus the map padding)
    case FullMap = 0.0
    case MapWithLegend = 0.50
    case HalfSite = 0.60
    case FullSite = 1.00
}
