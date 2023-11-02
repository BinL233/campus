//
//  Buttons.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import SwiftUI

struct Buttons: View {
    @Environment(Manager.self) var manager
    @Binding var mapKind : MapKind
    
    var body: some View {
        HStack {
            Spacer()
            FavoritesSelectButton()
            Spacer()
            BuildingsButton()
            Spacer()
            DeselectButton()
            Spacer()
            RouteButton()
            Spacer()
            MapPickerButton(mapKind: $mapKind)
            Spacer()
        }
    }
}
