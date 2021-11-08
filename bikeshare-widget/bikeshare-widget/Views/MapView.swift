import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var widgetInfo: WidgetInfo
    
    @State private var showSheet = false
    @State private var destinationLocation: CLLocationCoordinate2D?
    @ObservedObject private var locationsViewModel = LocationsViewModel()
    
    var body: some View {
        VStack {
            AnnotatableRouteMapView(destinationLocation: $destinationLocation,
                                    region: $locationsViewModel.region)
                .onAppear {
                    locationsViewModel.updateLocationAndStations()
                }
                ._onBindingChange($locationsViewModel.region) { newRegion in
                    if widgetInfo.route {
                        destinationLocation = locationsViewModel.stations.first?.coordinates
                    }
                }
            Button("Stations") {
                showSheet.toggle()
            }
            .disabled(locationsViewModel.stations.isEmpty)
            .padding()
            .sheet(isPresented: $showSheet) {
                List(locationsViewModel.stations) { station in
                    StationRow(station: station)
                        .onTapGesture {
                            destinationLocation = station.coordinates
                            widgetInfo.route = false
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
