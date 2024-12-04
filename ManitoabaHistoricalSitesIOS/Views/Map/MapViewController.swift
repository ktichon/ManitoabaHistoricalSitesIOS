//
//  MapViewController.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//


//
//  MapController.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-11-29.
//
import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    
    //let defaultZoom : Float = 18.0
    
    let map =  GMSMapView()
    var isAnimating: Bool = false
    

    override func loadView() {
        super.loadView()
        
        
        //Now done in MapViewControllerBridge
        //sets the camera to the Manitoba Museum
        //map.camera = GMSCameraPosition.camera(withLatitude: 49.9000253, longitude: -97.1386276, zoom: defaultZoom)
        
        do {
            // Gets the style JSON string from the enum raw value, and applies dark mode if it's dark mode
            let mapStyle = self.traitCollection.userInterfaceStyle == .dark ? MapStyles.night : MapStyles.day
            
            map.mapStyle = try GMSMapStyle(jsonString: mapStyle.rawValue)
        } catch {
            let nsError = error as NSError
            print("MapViewController.LoadView.Error setting the map style: \(nsError.localizedDescription)")
        }
        
        
        self.view = map
    }
    
}
