//
//  CampusApp.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//

import SwiftUI

@main
struct CampusApp: App {
    var body: some Scene {
        @State var manager = Manager()
        WindowGroup {
            RootView()
                .environment(manager)
        }
    }
}
