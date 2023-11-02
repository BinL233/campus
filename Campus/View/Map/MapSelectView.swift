//
//  MapSelectView.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import SwiftUI
import MapKit

struct MapSelectView: View {
    @Binding var mapKind : MapKind
    @Environment(Manager.self) var manager
    @Binding var position : MapCameraPosition
    @Binding var selectedPlace : Contents?
    
    var body : some View {
        switch mapKind {
        case .SwiftUI:
            SwiftUIView(position: $position, selectedPlace: $selectedPlace)

        case .UIKit:
            MapViewUIKit(selectedPlace: $selectedPlace)
        }
    }
}
