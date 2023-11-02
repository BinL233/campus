//
//  SwiftUIView.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let universityPark1 = CLLocationCoordinate2D(latitude: 40.791116, longitude: -77.864556)
    static let universityPark2 = CLLocationCoordinate2D(latitude: 40.811116, longitude: -77.864556)
    
    init(coord:Coord) {
        self = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
    }
}

struct SwiftUIView: View {
    @Environment(Manager.self) var manager
    @Binding var position : MapCameraPosition
    @Binding var selectedPlace : Contents?
    
    var body: some View {
        ZStack {
            Text("\(manager.instSelection)")
            Map(position: $position, selection: $selectedPlace) {
                UserAnnotation()
                
                if manager.currentState == .regular {
                    mapped
                    initPosition1
                    initPosition2
                }
                
                if manager.currentState == .routes {
                    routes
                    sourceAndDestination
                    
                    if manager.isCurrentLocation() {
                        currLocationSAD
                    }
                }
            }
        }
    }
}

extension SwiftUIView {
    var mapped : some MapContent {
        ForEach(manager.buildingsList) { item in
            if item.mapped {
                if item.favorites {
                    Marker(item.name, systemImage: "heart.fill", coordinate: .init(coord: Coord(latitude: item.latitude, longitude: item.longitude))).tag(item)
                        .tint(.red)
                } else {
                    Marker(item.name, coordinate: .init(coord: Coord(latitude: item.latitude, longitude: item.longitude))).tag(item)
                        .tint(.orange)
                }
            }
        }
    }
    
    var initPosition1 : some MapContent {
        Annotation("", coordinate: .universityPark1, content: {})
    }
    
    var initPosition2 : some MapContent {
        Annotation("", coordinate: .universityPark2, content: {})
    }
    
    var routes : some MapContent {
        ForEach(manager.routes, id:\.self) {route in
            ForEach(Array(route.steps.indices), id:\.self) { i in
                if manager.instSelection != i {
                    MapPolyline(route.steps[i].polyline)
                        .stroke(Color.blue, lineWidth: 5)
                } else {
                    MapPolyline(route.steps[i].polyline)
                        .stroke(Color.red, lineWidth: 5)
                }
            }
        }
    }
    
    var sourceAndDestination : some MapContent {
        ForEach(manager.buildingsList) { item in
            if item.name == manager.source.name || item.name == manager.destination.name {
                Marker(item.name, coordinate: .init(coord: Coord(latitude: item.latitude, longitude: item.longitude))).tag(item)
                    .tint(.blue)
            }
        }
    }
    
    var currLocationSAD : some MapContent {
        Marker(manager.currentLocation.name, coordinate: .init(coord: Coord(latitude: manager.currentLocation.latitude, longitude: manager.currentLocation.longitude))).tag(manager.currentLocation)
            .tint(.blue)
    }
}
