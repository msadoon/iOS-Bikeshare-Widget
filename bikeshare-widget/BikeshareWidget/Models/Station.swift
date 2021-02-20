import SwiftUI
import MapKit

struct Station: Identifiable {
    let id: String
    let address: String
    let bikeCapacity: Int
    let distance: Float
    
    var region: MKCoordinateRegion {
        let latitude = CLLocationDegrees(43.651890)
        let longitude = CLLocationDegrees(-79.381706)
        
        let locationCoord = CLLocationCoordinate2DMake(latitude, longitude)
        
        return MKCoordinateRegion(center: locationCoord,
                                  latitudinalMeters: 1000.0,
                                  longitudinalMeters: 1000.0)
    }
}
