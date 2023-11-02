//
//  FavoriteButton.swift
//  Campus
//
//  Created by Kaile Ying on 10/1/23.
//

import SwiftUI

struct FavoriteButton: View {
    @Environment(Manager.self) var manager
    let bldg : Contents
    
    var body: some View {
        let index : Int = manager.MatchIndex(building: bldg)
        Button(action: {manager.favorToggleButton(building: bldg)}) {
            if manager.buildingsList[index].favorites {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .font(.title)
            } else {
                Image(systemName: "heart")
                    .foregroundStyle(.red)
                    .font(.title)
            }
        }
    }
}

#Preview {
    FavoriteButton(bldg: Manager().buildingsList[0])
        .environment(Manager())
}
