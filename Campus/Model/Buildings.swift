//
//  Buildings.swift
//  Campus
//
//  Created by Kaile Ying on 9/30/23.
//

import Foundation
import MapKit
import Observation

// For buildings.json

struct Coord : Hashable, Codable {
    var latitude : Double
    var longitude : Double
}

@Observable
class Contents : NSObject, Identifiable, MKAnnotation, Codable {
    var coordinate: CLLocationCoordinate2D
    
    var id = UUID()
    let latitude : Double
    let longitude : Double
    let name : String
    var mapped : Bool
    var favorites : Bool
    let opp_bldg_code : Int?
    let year_constructed : Int?
    let photo : String?
    var customized : Bool?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case name
        case opp_bldg_code
        case year_constructed
        case photo
        case mapped
        case favorites
    }
    
    init(id: UUID = UUID(), latitude: Double, longitude: Double, name: String, mapped: Bool, favorites: Bool, opp_bldg_code: Int?, year_constructed: Int?, photo: String?, customized: Bool?) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.mapped = mapped
        self.favorites = favorites
        self.opp_bldg_code = opp_bldg_code
        self.year_constructed = year_constructed
        self.photo = photo
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.customized = customized
        super.init()
    }
    
    override var hash: Int {
        return id.hashValue
    }
    
    static func == (lhs: Contents, rhs: Contents) -> Bool {
            return lhs.id == rhs.id
    }
    
    static let standard = Contents(latitude: 40.8017390346291, longitude: -77.8543146925926, name: "Curry Hall", mapped: false, favorites: false, opp_bldg_code: 270002, year_constructed: 2004, photo: nil, customized: false)
    
    static var buildings : [Contents]? = {
        return Persistences(filename: "buildings").components
    }()
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        name = try values.decode(String.self, forKey: .name)
        mapped = try values.decodeIfPresent(Bool.self, forKey: .mapped) ?? false
        favorites = try values.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        opp_bldg_code = try values.decodeIfPresent(Int.self, forKey: .opp_bldg_code)
        year_constructed = try values.decodeIfPresent(Int.self, forKey: .year_constructed)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        super.init()
    }
}

extension Contents {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(name, forKey: .name)
        try container.encode(mapped, forKey: .mapped)
        try container.encode(favorites, forKey: .favorites)
        
        if let opp_bldg_code = opp_bldg_code {
            try container.encode(opp_bldg_code, forKey: .opp_bldg_code)
        }
        
        if let year_constructed = year_constructed {
            try container.encode(year_constructed, forKey: .year_constructed)
        }
        
        if let photo = photo {
            try container.encode(photo, forKey: .photo)
        }
    }
}

