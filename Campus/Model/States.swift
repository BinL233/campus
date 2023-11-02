//
//  States.swift
//  Campus
//
//  Created by Kaile Ying on 10/8/23.
//

import Foundation

enum States: String, CaseIterable, Identifiable {
    case regular, routes
    var id: Self { self }
}
