//
//  BuildingsButton.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//

import SwiftUI

struct BuildingsButton: View {
    @Environment(Manager.self) var manager
    @State private var isSheetPresented = false
    
    var body: some View {
        Button(action: {
            manager.BuildingButton()
            isSheetPresented.toggle()
        }, label: {
            Image(systemName: "building.columns")
                .font(.title2)
                .sheet(isPresented: $isSheetPresented) {
                    NavigationView {
                        BuildingsList()
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button("Dismiss") {
                                        isSheetPresented.toggle()
                                    }
                                }
                            }
                    }
                    BuildingListFilter(manager: _manager)
                }
        })
    }
}

#Preview {
    BuildingsButton()
        .environment(Manager())
}
