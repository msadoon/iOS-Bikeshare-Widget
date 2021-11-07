import SwiftUI
import WidgetKit
import MapKit

struct AppView: View {
    @StateObject var routeFromWidget = WidgetInfo()
    
    var body: some View {
        NavigationView {
            MapView()
            .navigationTitle("Nearest Locations")
            .onOpenURL { url in
                let latitudeAndLongitude = url.absoluteString.components(separatedBy: "/").dropFirst(2)
                
                if let latitude = latitudeAndLongitude.first as NSString?,
                   let longitude = latitudeAndLongitude.last as NSString? {
                    routeFromWidget.updateCoordinate(latitude: latitude.doubleValue,
                                                     longitude: longitude.doubleValue)
                    routeFromWidget.route = true
                    routeFromWidget.updateMap = true
                }
            }
        }
        .environmentObject(routeFromWidget)
    }
}

