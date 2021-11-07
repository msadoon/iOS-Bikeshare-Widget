import SwiftUI
import MapKit

class WidgetInfo: ObservableObject {
    @Published var route = false
    @Published var updateMap = false
    @Published var widgetsUserLocation = LocationDefaults.coordinate
    
    func updateCoordinate(latitude: CLLocationDegrees,
                          longitude: CLLocationDegrees) {
        widgetsUserLocation = CLLocationCoordinate2D(latitude: latitude,
                                                     longitude: longitude)
    }
}
