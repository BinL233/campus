//
//  BuildingsList.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//

import SwiftUI

struct BuildingsList: View {
    @Environment(Manager.self) var manager
    
    var body: some View {
        let lst = manager.BuildingFilter(input: manager.buildingsList, selection: manager.listFilterSelection)
        List {
            ForEach(lst) { bldg in
                Button(action: {manager.MappedToggleButton(building: bldg)}){
                    HStack {
                        if bldg.mapped {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "circle")
                        }
                        Text(bldg.name)
                            .foregroundStyle(.black)
                        Spacer()
                        if bldg.favorites {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BuildingsList()
        .environment(Manager())
}
