//
//  MapViewControllerBridge.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//
import GoogleMaps
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    @Binding var siteMarkers: [GMSMarker]
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        siteMarkers.forEach{ $0.map = uiViewController.map        }
    }
    
    
    
}
