//
//  Manager+Location.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import Foundation
import CoreLocation

extension Manager : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func updateCurrentLocation() {
        currentLocation = Contents(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, name: "Current Location", mapped: false, favorites: false, opp_bldg_code: 000, year_constructed: 000, photo: "", customized: false)
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D {
        var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        if locationManager.location != nil {
            location = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        }
        
        return location
    }
}
