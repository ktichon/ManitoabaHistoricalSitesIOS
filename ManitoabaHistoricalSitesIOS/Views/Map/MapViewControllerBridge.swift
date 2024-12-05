//
//  MapViewControllerBridge.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//
import GoogleMaps
import GoogleMapsUtils
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    @Binding var siteMarkers: [GMSMarker]
    @Binding var locationEnable: Bool
    @Binding var newMapLoad: Bool
    
    let defaultZoom : Float = 18.0
    
    
    
    
    func makeUIViewController(context: Context) -> MapViewController {
        //Makes the MapViewController
        let mapViewController = MapViewController()
        mapViewController.map.isMyLocationEnabled = locationEnable
        
        
        //Default Location is the Manitoba Museum
        var startingLocation = HistoricalSite().position
        
        //If location is enabled and the user location isn't nill, use user location
        if(locationEnable){
            startingLocation = mapViewController.map.myLocation?.coordinate ?? startingLocation
        }
        
        //Move the camera to the starting location
        mapViewController.map.camera = GMSCameraPosition(latitude: startingLocation.latitude, longitude: startingLocation.longitude, zoom: defaultZoom)
        
        
        //Adds the compass button
        mapViewController.map.settings.compassButton = true
        
        //Sets the coordinator as the delagete
        //mapViewController.map.delegate = context.coordinator
        
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapViewController.map, clusterIconGenerator: iconGenerator)
        
        mapViewController.clusterManager = GMUClusterManager(map: mapViewController.map, algorithm: algorithm, renderer: renderer)
        mapViewController.clusterManager.setMapDelegate(context.coordinator)
        
        return mapViewController
    }
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        //Sets if user location is enabled
        uiViewController.map.isMyLocationEnabled = locationEnable
        
        if locationEnable {
            //Adds the "go to user location" button
            uiViewController.map.settings.myLocationButton = true
            
            //gets the camera to center on the user the first time the map loads
            if newMapLoad && uiViewController.map.myLocation?.coordinate != nil{
                uiViewController.map.camera = GMSCameraPosition(
                    latitude: uiViewController.map.myLocation!.coordinate.latitude,
                    longitude: uiViewController.map.myLocation!.coordinate.longitude,
                    zoom: defaultZoom)
                newMapLoad = false
                
            }
        }
        
        
        
        if uiViewController.clusterManager != nil {
            //Adds site to cluster manager
            uiViewController.clusterManager.clearItems()
            //var firstMarker = siteMarkers[0]
            uiViewController.clusterManager.add(siteMarkers)
            uiViewController.clusterManager.cluster()
        }
        //siteMarkers.forEach{ $0.map = uiViewController.map        }
    }
    
    
    //Creates the MapViewCoordinator
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(mapViewControllerBridge: self)
    }
    
    
    //Listens to the events called in the map (such as on marker click)
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapViewControllerBridge
        
        init(mapViewControllerBridge: MapViewControllerBridge) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if marker.userData is GMUCluster {
                print("Cluster was tapped")
                return true
            }
            
            print("Marker was tapped")
            return false
        }
    }
}