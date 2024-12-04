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
    @Binding var locationEnable: Bool
    @Binding var userLocation: CLLocationCoordinate2D
    
    let defaultZoom : Float = 18.0
    
    func makeUIViewController(context: Context) -> MapViewController {
        let mapViewController = MapViewController()
        mapViewController.map.camera = GMSMutableCameraPosition(latitude: userLocation.latitude, longitude: userLocation.longitude, zoom: defaultZoom)
        mapViewController.map.settings.compassButton = true
        return mapViewController
    }
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.map.isMyLocationEnabled = locationEnable
        if locationEnable {
            uiViewController.map.settings.myLocationButton = true
        }
        siteMarkers.forEach{ $0.map = uiViewController.map        }
    }
    
    
    
}
