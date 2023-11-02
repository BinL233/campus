//
//  RouteButton.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import SwiftUI
import MapKit

struct RouteButton: View {
    @Environment(Manager.self) var manager
    @State private var isSheetPresented = false
    
    var body: some View {
        @Bindable var manager = manager
        
        Button(action: {
            isSheetPresented.toggle()
            manager.updateCurrentLocation()
            manager.source = manager.currentLocation
        }) {
            Image(systemName: "map")
                .font(.title2)
                .sheet(isPresented: $isSheetPresented, content: {
                    NavigationView {
                        VStack {
                            HStack {
                                Spacer()
                                Text("From")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                                Picker("source", selection: $manager.source) {
                                    Text("Current location").tag(manager.currentLocation)
                                    ForEach(manager.buildingsList) { bldg in
                                        let bldgName = bldg.name
                                        Text("\(bldgName)").tag(bldg)
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            HStack {
                                Spacer()
                                Text("To")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                                Picker("destination", selection: $manager.destination) {
                                    Text("Current location").tag(manager.currentLocation)
                                    ForEach(manager.buildingsList) { bldg in
                                        let bldgName = bldg.name
                                        Text("\(bldgName)").tag(bldg)
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            
                            Button("Start") {
                                manager.instSelection = 0
                                manager.provideDirections(bldg1: manager.source, bldg2: manager.destination)
                                isSheetPresented.toggle()
                                manager.currentState = .routes
                            }
                            .font(.title)
                            .padding()
                            
                        }
                    }
                    .presentationDetents([.fraction(0.3),.medium])
                })
        }
    }
}

#Preview {
    RouteButton()
        .environment(Manager())
}
