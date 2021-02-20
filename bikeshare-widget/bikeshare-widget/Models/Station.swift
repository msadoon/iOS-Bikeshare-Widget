//
//  Station.swift
//  bikeshare-widget
//
//  Created by Tom McNeely on 2021-02-20.
//

import Foundation
import CoreLocation

struct Station: Decodable {
    
    let name: String
    let address: String
    let capacity: Int
    let nearbyDistance: Int
    let coordinates: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case name
        case address
        case capacity
        case nearbyDistance = "nearby_distance"
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        capacity = try container.decode(Int.self, forKey: .capacity)
        nearbyDistance = try container.decode(Int.self, forKey: .capacity)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
