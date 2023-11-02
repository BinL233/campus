//
//  MapViewCoordinator.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import Foundation
import MapKit

class MapViewCoordinator : NSObject, MKMapViewDelegate {
    var map: MKMapView?
    var locationButton: UIButton?
    var manager: Manager?
    var parent: MapViewUIKit?
    
    init(_ parent: MapViewUIKit, manager: Manager) {
        self.parent = parent
        self.manager = manager
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let buildingAnnotation = annotation as? Contents else { return nil }
        
        if !buildingAnnotation.mapped {
            return nil
        }
        
        let identifier = "buildingMarker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.clusteringIdentifier = "buildingCluster"
        } else {
            annotationView?.annotation = buildingAnnotation
        }
        annotationView?.displayPriority = .required
        
        if buildingAnnotation.favorites {
            annotationView?.glyphImage = UIImage(systemName: "heart.fill")
            annotationView?.glyphTintColor = .white
            annotationView?.markerTintColor = .red
        } else {
            annotationView?.markerTintColor = .orange
        }
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let buildingAnnotation = view.annotation as? Contents {
            parent?.selectedPlace = buildingAnnotation
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        guard let userLocation = map?.userLocation.location?.coordinate else { return }
        if arePositionEqual(mapView.region.center.latitude, userLocation.latitude) && arePositionEqual(mapView.region.center.longitude, userLocation.longitude) {
            locationButton?.isHidden = true
        } else {
            locationButton?.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polylineOverlay = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let polyLineRenderer = MKPolylineRenderer(overlay: overlay)
        var index : Int = 0
        for i in (0..<(manager?.routes[0].steps.count)!) {
            if polylineOverlay === manager?.routes[0].steps[i].polyline {
                index = i
            }
        }
        
        if index == manager?.instSelection {
            polyLineRenderer.strokeColor = UIColor.systemRed
        } else {
            polyLineRenderer.strokeColor = UIColor.systemBlue
        }
        polyLineRenderer.lineWidth = 4.0
        return polyLineRenderer
    }
    
    func arePositionEqual(_ coord1: CLLocationDegrees, _ coord2: CLLocationDegrees, epsilon: CLLocationDegrees = 0.0001) -> Bool {
        return abs(coord1 - coord2) < epsilon
    }
    
    @objc
    func centerToUserLocation() {
        if let userLocation = map?.userLocation.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            map?.setRegion(region, animated: true)
        }
        locationButton?.isHidden = true
    }
    
    @objc func changeMapConfig(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            map?.mapType = .standard
        case 1:
            map?.mapType = .hybrid
        case 2:
            map?.mapType = .satellite
        default:
            break
        }
    }
    
    @objc 
    func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let touchPoint = gesture.location(in: map)
            let coordinate = map?.convert(touchPoint, toCoordinateFrom: map)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
            
            map?.addAnnotation(annotation)
            manager?.extraAnnotations.append(Contents(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0, name: "", mapped: false, favorites: false, opp_bldg_code: 0, year_constructed: 0, photo: "", customized: true))
        }
    }
}
