//
//  Manager+InstructionCtl.swift
//  Campus
//
//  Created by Kaile Ying on 10/8/23.
//

import Foundation

extension Manager {
    func PreviousInstruction() {
        if instSelection > 0 {
            instSelection -= 1
        }
    }
    
    func NextInstruction() {
        if instSelection < instructions.count - 1 {
            instSelection += 1
        }
    }
}
