import SwiftUI
import WidgetKit

struct AppView: View {
    var body: some View {
        NavigationView {
            MapView()
            .navigationTitle("Nearest Locations")
        }
    }
}

