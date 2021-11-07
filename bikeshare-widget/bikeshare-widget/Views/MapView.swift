import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject private var locationsViewModel = LocationsViewModel()
    @ObservedObject private var stationsViewModel = StationsViewModel()
    
    @State private var showSheet = false
    @State private var stationsUpdatedToClosestUser = false
    @State private var destinationLocation: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            AnnotatableRouteMapView(destinationLocation: $destinationLocation,
                                    defaultRegion: $locationsViewModel.region)
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
                stationsUpdatedToClosestUser = false
            }
            .onChange(of: locationsViewModel.region) { region in
                let userCurrentLocation = CLLocation(latitude: region.center.latitude,
                                                     longitude: region.center.longitude)
                
                stationsViewModel.updateStations(to: userCurrentLocation,
                                                 maxMetersDistance: nil)
                stationsUpdatedToClosestUser = true
            }
        }
        .sheet(isPresented: $showSheet) {
            List(stationsViewModel.stations) { station in
                StationRow(station: station)
                    .onTapGesture {
                        destinationLocation = station.coordinates
                        showSheet.toggle()
                    }
            }
            .padding(EdgeInsets(top: 50.0,
                                leading: 5.0,
                                bottom: 10.0,
                                trailing: 5.0))
        }
    }
}
