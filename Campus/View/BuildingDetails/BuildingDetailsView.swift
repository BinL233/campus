//
//  BuildingDetailsView.swift
//  Campus
//
//  Created by Kaile Ying on 10/1/23.
//

import SwiftUI

struct BuildingDetailsView: View {
    @Environment(Manager.self) var manager
    let building: Contents
    @Binding var selectedPlace: Contents?
    
    var body: some View {
        VStack(alignment:.leading) {
            if !(building.customized ?? false) {
                HStack {
                    Spacer()
                    FavoriteButton(bldg: building)
                        .padding()
                }
                Text(building.name).font(.title)
                if let year = building.year_constructed {
                    Text("Year of construction: \(String(year))")
                }
                if let image = building.photo {
                    Image("\(image)")
                        .resizable()
                        .scaledToFit()
                }
            } else {
                VStack {
                    Spacer()
                    Button(action: {
                        manager.updateCurrentLocation()
                        manager.source = manager.currentLocation
                        print(manager.currentLocation, manager.currentLocation)
                        manager.destination = building
                        manager.instSelection = 0
                        manager.provideDirections(bldg1: manager.source, bldg2: manager.destination)
                        manager.currentState = .routes
                        selectedPlace = nil
                    }) {
                        Text("Start Navigation")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        manager.deleteCurrentMarkerButton(anno: building)
                        selectedPlace = nil
                    }, label: {
                        Text("Delete This Marker")
                    })
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        manager.deleteAllCustomizedMarkerButton()
                        selectedPlace = nil
                    }, label: {
                        Text("Delete All Customized Marker")
                    })
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }

            
        }.padding()
        Spacer()
    }
}
