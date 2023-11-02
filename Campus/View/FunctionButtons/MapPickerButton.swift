//
//  MapPicker.swift
//  Campus
//
//  Created by Kaile Ying on 10/14/23.
//

import SwiftUI

struct MapPickerButton: View {
    @Binding var mapKind : MapKind
    
    var body: some View {
        
        Menu {
            if mapKind == .SwiftUI {
                Button("UIKit Map") { mapKind = .UIKit}
            } else {
                Button("SwiftUI Map") { mapKind = .SwiftUI}
            }

             } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                     .font(.title2)
            }

    }
}
