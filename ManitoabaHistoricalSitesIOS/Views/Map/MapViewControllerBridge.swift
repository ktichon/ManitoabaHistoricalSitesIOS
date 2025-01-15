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
    
    //Used to center camera on user when the map first loads
    @Binding var newMapLoad: Bool
    
    //The bottom padding for the map
    var mapBottomPadding: CGFloat
    
    //Keeps track of the selected marker on the map
    @Binding var selectedMarker : GMSMarker?
    //Keeps track if the site marker was clicked on or if the msrker was selected in the search bar
    @Binding var siteSelectedBySearch : Bool
    
    var newSiteSelected: (Int) -> Void
    
    let defaultZoom : Float = 18.0
    let searchZoomLevel : Float = 19
    
    
    
    
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
        
        
        //let iconGenerator = GMUDefaultClusterIconGenerator()
        let iconGenerator = MapClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapViewController.map, clusterIconGenerator: iconGenerator)
        
        mapViewController.clusterManager = GMUClusterManager(map: mapViewController.map, algorithm: algorithm, renderer: renderer)
        mapViewController.clusterManager.setMapDelegate(context.coordinator)
        
        return mapViewController
    }
    
    //Called whenever binded values are updated
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
        
        //Sets the bottom map padding based off the displayState
        uiViewController.map.padding = UIEdgeInsets(top: 0, left: 0, bottom: mapBottomPadding, right: 0)
        
        //siteMarkers.forEach{ $0.map = uiViewController.map        }
        
        //When a marker is elected
        if let notNullSelectedMarker = selectedMarker  {
            // If is was selected by the search bar, zoom to location
            if siteSelectedBySearch {
                uiViewController.map.camera = GMSCameraPosition(target: notNullSelectedMarker.position, zoom: searchZoomLevel)
            }
            //Set the selected marker on the map to nil, to hide the marker info window
            uiViewController.map.selectedMarker = nil
            //Sets the binded varible to nil, so that this triggers when a marker is first selected
            selectedMarker = nil
            
        }
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
                //print("Cluster was tapped")
                //If Cluser was clicked, zoom in
                let cameraUpdate = GMSCameraUpdate.setTarget(marker.position, zoom: mapView.camera.zoom + 1)
                mapView.animate(with: cameraUpdate)
                return true
            }
            
            
            

            //If marker was clicked, call newSiteSelected from the ViewModel
            if let selectedSiteId = marker.userData as? Int {
                //Lets the map know that the site marker was clicked on, so no need to move the camera
                mapViewControllerBridge.siteSelectedBySearch = false
                //Calls an update to the mapViewControllerBridge that will hide the marker info window
                mapViewControllerBridge.selectedMarker = marker
                
                
                //print("Site \(selectedSite.name) was tapped")
                mapViewControllerBridge.newSiteSelected(selectedSiteId)
            } else{
                print("Unknown marker was tapped")
            }
            
            return false
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return nil
    }
}
