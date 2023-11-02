//
//  FavoritesControlButton.swift
//  Campus
//
//  Created by Kaile Ying on 10/1/23.
//
//
import SwiftUI

struct FavoritesSelectButton: View {
    @Environment(Manager.self) var manager
    var body: some View {
        Button(action: {manager.FavorSelectionCtlButton(cond: manager.isFavorAllSelect)}) {
            if manager.isFavorAllSelect {
                Image(systemName: "checkmark.diamond.fill")
                    .font(.title2)
            } else {
                Image(systemName: "checkmark.diamond")
                    .font(.title2)
            }
        }
    }
}

#Preview {
    FavoritesSelectButton()
        .environment(Manager())
}
