//
//  LocationManager.swift
//  ManitoabaHistoricalSitesIOS
//
//  Created by Kyle Tichon on 2024-12-04.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject{
    
    //Last known location of the user, defaults to the Manitoba Museum
    @Published var lastKnownLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 49.9000253, longitude: -97.1386276)
    var manager = CLLocationManager()
    
    //Used to check if location permissions are enabled
    @Published var locationEnabled : Bool = false
    
    //Used to center the camera on the user when the map first loads and has user location
    @Published var newMapLoad : Bool = true

    
    override init(){
        super.init()
        manager.delegate = self
        self.checkLocationAuthorization()
    }
    
    
    //Checks if the user has allowed location permissions
    func checkLocationAuthorization()  {
        //Sets the CLLocationManager
        
        
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            //Ask the user for location permission
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationEnabled = true
            //If authorized, then get user location
            updateLastKnownLocation(newLocation: manager.location?.coordinate)
        default:
            //Location permissions were not authorized
            locationEnabled = false
            print("Location services are disabled")
        }
    }
    
    //On Authorization change, call checkLocationAuthorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)  {
        checkLocationAuthorization()
    }
    
    //On user location update, update lastKnowLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateLastKnownLocation(newLocation: locations.first?.coordinate)
        
    }
    
    
    //Only updated lasKnowLocation if the new value is not null
    func updateLastKnownLocation(newLocation : CLLocationCoordinate2D?) {
        //Unwraps the nullable location
        if let locationNotNull = newLocation  {
            lastKnownLocation = locationNotNull
        }
    }
}
