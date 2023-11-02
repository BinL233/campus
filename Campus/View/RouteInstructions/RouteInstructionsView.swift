//
//  RouteInstructionsView.swift
//  Campus
//
//  Created by Kaile Ying on 10/8/23.
//

import SwiftUI

struct RouteInstructionsView: View {
    @Environment(Manager.self) var manager
    
    var body: some View {
        TabView {
            VStack {
                if manager.instructions.count > 0 {
                    Text("\(manager.instructions[manager.instSelection].instructions)")
                        .padding(.top, 10)
                        .tabViewStyle(.page)
                }
            
                Text("Expected travel time: \(formattedTravelTime)")
                    .padding(.bottom)
                
                HStack {
                    Spacer()
                    
                    Button(action: {manager.PreviousInstruction()}, label: {
                        Text("Previous")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    Button(action: {manager.NextInstruction()}, label: {
                        Text("Next")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
                
                Button(action: {manager.currentState = .regular}, label: {
                    Text("Stop showing routes")
                })
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    RouteInstructionsView()
        .environment(Manager())
}
extension RouteInstructionsView {
    var formattedTravelTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .short
        return formatter.string(from: manager.routes.first?.expectedTravelTime ?? 0) ?? ""
    }
}
