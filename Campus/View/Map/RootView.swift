//
//  ContentView.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//
import SwiftUI
import MapKit

enum MapKind {
    case SwiftUI, UIKit
}

struct RootView: View {
    @Environment(Manager.self) var manager
    @State private var mapKind : MapKind = .UIKit
    @State private var position : MapCameraPosition = .automatic
    @State private var selectedPlace : Contents?
    
    var body: some View {
        @Bindable var manager = manager
        VStack{
            MapSelectView(mapKind: $mapKind, position: $position, selectedPlace: $selectedPlace)
                .padding(.top)
                .sheet(item: $selectedPlace, content: { bldg in
                    BuildingDetailsView(building: bldg, selectedPlace: $selectedPlace)
                        .presentationDetents([.fraction(0.3),.medium])
                })
                .mapControls {
                    MapUserLocationButton()
                        .mapControlVisibility(position.followsUserLocation ? .hidden : .visible)
                }
                .safeAreaInset(edge: .top) {
                    VStack{
                        Buttons(mapKind: $mapKind)
                    }
                }
            if manager.currentState == .routes {
                RouteInstructionsView()
            }
        }
    }
}

#Preview {
    RootView()
       .environment(Manager())
}
