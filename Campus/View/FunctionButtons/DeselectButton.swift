//
//  MappedControlButton.swift
//  Campus
//
//  Created by Kaile Ying on 10/1/23.
//

import SwiftUI

struct DeselectButton: View {
    @Environment(Manager.self) var manager
    var body: some View {
        Button(action: {manager.DeselectAllButton()}) {
            Image(systemName: "multiply")
                .font(.title2)
        }
    }
}

#Preview {
    DeselectButton()
        .environment(Manager())
}
