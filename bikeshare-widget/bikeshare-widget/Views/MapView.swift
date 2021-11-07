import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject private var locationsViewModel = LocationsViewModel()
    @ObservedObject private var stationsViewModel = StationsViewModel()
    
    @State private var showSheet = false
    @State private var userTrackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $locationsViewModel.region,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode)
                .onAppear {
                    locationsViewModel.checkIfLocationServicesIsEnabled()
                }
            Button("Stations") {
                showSheet.toggle()
            }
            .disabled(!stationsViewModel.stationsUpdatedForUserLocation)
            .padding()
            .onChange(of: locationsViewModel.region) { region in
                stationsViewModel.getStations(userLocation: locationsViewModel.userLocation)
            }
        }
        .sheet(isPresented: $showSheet) {
            List(stationsViewModel.stations) { station in
                StationRow(station: station)
            }
            .padding(EdgeInsets(top: 50.0,
                                leading: 5.0,
                                bottom: 10.0,
                                trailing: 5.0))
        }
    }
}
