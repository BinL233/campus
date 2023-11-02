//
//  UIKitCam.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import Foundation
import UIKit
import MapKit

extension Manager {
    func regionCalc(for locations: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        var minLatitude: CLLocationDegrees = 90.0
        var maxLatitude: CLLocationDegrees = -90.0
        var minLongitude: CLLocationDegrees = 180.0
        var maxLongitude: CLLocationDegrees = -180.0

        for location in locations {
            if location.latitude < minLatitude {
                minLatitude = location.latitude
            }
            if location.latitude > maxLatitude {
                maxLatitude = location.latitude
            }
            if location.longitude < minLongitude {
                minLongitude = location.longitude
            }
            if location.longitude > maxLongitude {
                maxLongitude = location.longitude
            }
        }

        let center = CLLocationCoordinate2D(latitude: (minLatitude + maxLatitude) / 2, longitude: (minLongitude + maxLongitude) / 2)
        let span = MKCoordinateSpan(latitudeDelta: maxLatitude - minLatitude, longitudeDelta: maxLongitude - minLongitude)

        return MKCoordinateRegion(center: center, span: span)
    }
}
