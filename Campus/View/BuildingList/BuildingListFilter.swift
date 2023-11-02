//
//  BuildingListFilter.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import SwiftUI

struct BuildingListFilter: View {
    @Environment(Manager.self) var manager
    
    var body: some View {
        @Bindable var manager = manager
        Picker("BuildingListFilter", selection: $manager.listFilterSelection) {
            Text("All Buildings").tag(ListFilter.allBuildings)
            Text("Favorited Buildings").tag(ListFilter.favoritedBuildings)
            Text("Selected Buildings").tag(ListFilter.currentlySelectedBuildings)
            Text("Nearby Buildings").tag(ListFilter.nearbyBuildings)
        }
    }
}

#Preview {
    BuildingListFilter()
        .environment(Manager())
}
