import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject private var locationsViewModel = LocationsViewModel()
    @ObservedObject private var stationsViewModel = StationsViewModel()
    
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $locationsViewModel.region,
                showsUserLocation: true)
                .onAppear {
                    locationsViewModel.checkIfLocationServicesIsEnabled()
                }
            Button("Stations") {
                showSheet.toggle()
            }
            .disabled(stationsViewModel.stations.isEmpty)
            .padding()
            .onAppear {
                stationsViewModel.getStations()
            }
        }
        .sheet(isPresented: $showSheet) {
            List(stationsViewModel.stations) { station in
                StationRow(station: station)
            }
        }
    }
}
