//
//  Manager+BuildingListFilter.swift
//  Campus
//
//  Created by Kaile Ying on 10/7/23.
//

import Foundation
import MapKit

extension Manager {
    func BuildingFilter(input: [Contents], selection: ListFilter) -> [Contents] {
        var output : [Contents] = []
        let allowedRange : Double = 0.0015
        
        if selection == ListFilter.allBuildings {
            return input
        } else if selection == ListFilter.favoritedBuildings {
            for x in input {
                if x.favorites {
                    output.append(x)
                }
            }
        } else if selection == ListFilter.currentlySelectedBuildings {
            for x in input {
                if x.mapped {
                    output.append(x)
                }
            }
        } else {
            for x in input {
                if abs(x.latitude - (locationManager.location?.coordinate.latitude)!) < allowedRange && abs(x.longitude - (locationManager.location?.coordinate.longitude)!) < allowedRange {
                    output.append(x)
                }
            }
        }
        
        return output
    }
}
