import SwiftUI
import WidgetKit
import MapKit

struct AppView: View {
    @ObservedObject var routeFromWidget = WidgetInfo()
    
    var body: some View {
        NavigationView {
            MapView()
            .navigationTitle("Nearest Locations")
            .onOpenURL { _ in
                routeFromWidget.route = true
            }
        }
        .environmentObject(routeFromWidget)
    }
}

