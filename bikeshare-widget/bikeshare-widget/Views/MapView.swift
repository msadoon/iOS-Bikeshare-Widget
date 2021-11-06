import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject private var locationViewModel = LocationViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationViewModel.region,
                showsUserLocation: true)
                .onAppear {
                    locationViewModel.checkIfLocationServicesIsEnabled()
                }
        }
    }
}
