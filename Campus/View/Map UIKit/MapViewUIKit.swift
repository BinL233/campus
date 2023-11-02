//
//  MapViewUIKit.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import SwiftUI
import MapKit

struct MapViewUIKit : UIViewRepresentable {
    @Environment(Manager.self) var manager
    @Binding var selectedPlace : Contents?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        context.coordinator.map = mapView
        mapView.region = manager.region
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        let locationButton = UIButton(type: .system)
        locationButton.setImage(UIImage(systemName: "location.square.fill"), for: .normal)
        locationButton.imageView?.contentMode = .scaleAspectFit
        locationButton.addTarget(context.coordinator, action: #selector(context.coordinator.centerToUserLocation), for: .touchUpInside)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(locationButton)
        
        NSLayoutConstraint.activate([
            locationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            locationButton.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: 60),
            locationButton.widthAnchor.constraint(equalToConstant: 50),
            locationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        context.coordinator.locationButton = locationButton
        
        let mapConfigs = UISegmentedControl(items: ["Standard", "Hybrid", "Imagery"])
        mapConfigs.selectedSegmentIndex = 0
        mapConfigs.addTarget(context.coordinator, action: #selector(context.coordinator.changeMapConfig(_:)), for: .valueChanged)
        mapConfigs.backgroundColor = .lightGray
        mapConfigs.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(mapConfigs)
        
        NSLayoutConstraint.activate([
            mapConfigs.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10),
            mapConfigs.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
        ])
        
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if manager.currentState == .regular {
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeOverlays(mapView.overlays)
            
            var anno = manager.buildingsList.filter { $0.mapped }
            let extraAnno = manager.extraAnnotations
            anno = anno + extraAnno
            
            mapView.addAnnotations(anno)
            mapView.showAnnotations(anno, animated: true)
        } else {
            mapView.removeAnnotations(mapView.annotations)
            var naviAnno = manager.buildingsList.filter { $0.name == manager.source.name || $0.name == manager.destination.name }
            naviAnno = manager.extraAnnotations.filter {
                ($0.latitude == manager.source.latitude && $0.longitude == manager.source.longitude) || ( $0.latitude == manager.destination.latitude && $0.longitude == manager.destination.longitude )
            }
            
            mapView.addAnnotations(naviAnno)
            if naviAnno.count == 1 {
                naviAnno.append(manager.currentLocation)
            }
            mapView.showAnnotations(naviAnno, animated: true)
            
            mapView.removeOverlays(mapView.overlays)
            mapView.addOverlays(manager.polylines)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self, manager: manager)
    }
}
