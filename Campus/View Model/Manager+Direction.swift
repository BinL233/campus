//
//  Manager+Route.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import Foundation

import MapKit

extension Manager {
    func provideDirections(bldg1:Contents, bldg2:Contents)  {
        self.routes.removeAll()
        let request = MKDirections.Request()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: bldg2.latitude, longitude: bldg2.longitude)))
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: bldg1.latitude, longitude: bldg1.longitude)))
        request.transportType = .walking
        let directions = MKDirections(request: request)

        directions.calculate { response, error in
            guard error == nil else {return}
            if let route = response?.routes.first {
                self.routes.append(route)
                self.instructions.append(contentsOf: route.steps)
            }
        }
    }
    
    func isCurrentLocation() -> Bool {
        if currentLocation == source || currentLocation == destination {
            return true
        } else {
            return false
        }
    }
}
