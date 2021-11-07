import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var widgetInfo: WidgetInfo
    
    @ObservedObject private var locationsViewModel = LocationsViewModel()
    @ObservedObject private var stationsViewModel = StationsViewModel()
    
    @State private var showSheet = false
    @State private var destinationLocation: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            AnnotatableRouteMapView(destinationLocation: $destinationLocation,
                                    region: $locationsViewModel.region)
                .environmentObject(widgetInfo)
                .onAppear {
                    locationsViewModel.checkIfLocationServicesIsEnabled()
                }
                .onChange(of: locationsViewModel.region) { newRegion in
                    stationsViewModel.getStations() {
                        let userCurrentLocation = CLLocation(latitude: newRegion.center.latitude, longitude: newRegion.center.longitude)
                        
                        stationsViewModel.updateStations(to: userCurrentLocation,
                                                         maxMetersDistance: nil)
                    }
                    
                    if widgetInfo.route {
                        destinationLocation = stationsViewModel.stations.first?.coordinates
                    }
                }
            Button("Stations") {
                showSheet.toggle()
            }
            .disabled(stationsViewModel.stations.isEmpty)
            .padding()
            .sheet(isPresented: $showSheet) {
                List(stationsViewModel.stations) { station in
                    StationRow(station: station)
                        .onTapGesture {
                            destinationLocation = station.coordinates
                            widgetInfo.route = false
                            widgetInfo.updateMap = false
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
}
