//
//  BuildingListFilterList.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import Foundation

enum ListFilter: String, CaseIterable, Identifiable {
    case allBuildings, favoritedBuildings, currentlySelectedBuildings, nearbyBuildings
    var id: Self { self }
}
