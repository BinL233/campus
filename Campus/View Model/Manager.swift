//
//  Manage.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//

import Foundation
import MapKit
import Observation

@Observable
class Manager : NSObject {
    var isBuildingButtonPressed : Bool
    var buildingsList : [Contents]
    var listFilterSelection : ListFilter
    
    var source : Contents
    var destination : Contents
    var currentLocation : Contents
    
    var routes = [MKRoute]()
    var polylines : [MKPolyline] { routes.first?.steps.map { $0.polyline } ?? [] }
    
    var instructions : [MKRoute.Step]
    var instSelection : Int
    
    var currentState : States

    var isFavorAllSelect : Bool {
        for building in buildingsList {
            if building.favorites && !building.mapped {
                return false
            }
        }
        return true
    }
    
    var region : MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (CLLocationCoordinate2D.universityPark1.latitude + CLLocationCoordinate2D.universityPark2.latitude)/2, longitude: (CLLocationCoordinate2D.universityPark1.longitude + CLLocationCoordinate2D.universityPark2.longitude)/2), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    let locationManager : CLLocationManager
    var extraAnnotations : [Contents]
    
    override init() {
        let localBuildings : [Contents] = Contents.buildings ?? []
        let localBuildingsList : [Contents] = localBuildings.sorted { $0.name < $1.name }
        let localLocationManager = CLLocationManager()
        if let location = localLocationManager.location {
            let localCurrentLocation = Contents(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, name: "Current Location", mapped: false, favorites: false, opp_bldg_code: 000, year_constructed: 000, photo: "", customized: false)
            currentLocation = localCurrentLocation
            source = localCurrentLocation
        } else {
            let localCurrentLocation = Contents(latitude: 0, longitude: 0, name: "Current Location", mapped: false, favorites: false, opp_bldg_code: 000, year_constructed: 000, photo: "", customized: false)
            currentLocation = localCurrentLocation
            source = localCurrentLocation
        }
        
        isBuildingButtonPressed = false
        buildingsList = localBuildingsList
        listFilterSelection = .allBuildings
        locationManager = localLocationManager
        destination = localBuildingsList[0]
        
        instructions = []
        instSelection = 0
        
        currentState = .regular
        
        extraAnnotations = []
        
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    private func save() {
        Persistences(filename: "buildings").save(components: buildingsList)
    }
    
    private func ShowBuildingList() {
        if isBuildingButtonPressed {
            isBuildingButtonPressed = false
        } else {
            isBuildingButtonPressed = true
        }
    }
    
    private func FavorToggle(building: Contents) {
        for i in 0..<(buildingsList.count) {
            if buildingsList[i].id == building.id {
                buildingsList[i].favorites.toggle()
            }
        }
        save()
    }
    
    private func MappedToggle(building: Contents) {
        for i in 0..<(buildingsList.count) {
            if buildingsList[i].id == building.id {
                buildingsList[i].mapped.toggle()
            }
        }
        save()
    }
    
    private func FavorSelectionCtl(cond: Bool) {
        for i in 0..<(buildingsList.count) {
            if buildingsList[i].favorites {
                if cond {
                    buildingsList[i].mapped.toggle()
                } else {
                    buildingsList[i].mapped = true
                }
            }
        }
    }
    
    private func DeselectAll() {
        for i in 0..<(buildingsList.count) {
            buildingsList[i].mapped = false
        }
        save()
    }
    
    private func deleteCurrentMarker(anno: Contents) {
        for i in 0..<extraAnnotations.count {
            if extraAnnotations[i] == anno {
                extraAnnotations.remove(at: i)
            }
        }
    }
    
    private func deleteAllCustomizedMarker() {
        extraAnnotations = []
    }
        
    func MatchIndex(building: Contents) -> Int {
        for i in 0..<(buildingsList.count) {
            if buildingsList[i].id == building.id {
                return i
            }
        }
        return 0
    }
    
    func BuildingButton() {
        ShowBuildingList()
    }
    
    func favorToggleButton(building: Contents) {
        FavorToggle(building: building)
    }
    
    func MappedToggleButton(building: Contents) {
        MappedToggle(building: building)
    }
    
    func DeselectAllButton() {
        DeselectAll()
    }
    
    func FavorSelectionCtlButton(cond: Bool) {
        FavorSelectionCtl(cond: cond)
    }
    
    func deleteCurrentMarkerButton(anno: Contents) {
        deleteCurrentMarker(anno: anno)
    }
    
    func deleteAllCustomizedMarkerButton() {
        deleteAllCustomizedMarker()
    }
}

