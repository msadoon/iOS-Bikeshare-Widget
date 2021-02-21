import SwiftUI
import MapKit

struct Station: Identifiable {
    let id: String
    let address: String
    let bikeCapacity: Int
    let distance: Double
    let coordinates: CLLocationCoordinate2D
}
