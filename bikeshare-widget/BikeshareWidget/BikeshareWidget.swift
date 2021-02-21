import WidgetKit
import SwiftUI
import MapKit

struct MapEntry: TimelineEntry {
    let date: Date
    let nearestStations: [Station]
    let userLocation: MKCoordinateRegion
    let image: UIImage
}

struct NearbyStationProvider: TimelineProvider {
    static let emptyDataSet = [Station]()
    
    // TODO: Ensure user location is updated dynamically
    static var sampleUserLocation: MKCoordinateRegion {
        let latitude = CLLocationDegrees(43.651890)
        let longitude = CLLocationDegrees(-79.381706)
        
        let locationCoord = CLLocationCoordinate2DMake(latitude, longitude)
        
        return MKCoordinateRegion(center: locationCoord,
                                  latitudinalMeters: 1000.0,
                                  longitudinalMeters: 1000.0)
    }
    
    func placeholder(in context: Context) -> MapEntry {
        MapEntry(date: Date(), nearestStations: NearbyStationProvider.emptyDataSet, userLocation: NearbyStationProvider.sampleUserLocation, image: UIImage(systemName: "map")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (MapEntry) -> ()) {
        let nearestStations: [Station]
        
        if context.isPreview {
            nearestStations = NearbyStationProvider.emptyDataSet
        } else {
            nearestStations = loadNearestLocations(userLocation: NearbyStationProvider.sampleUserLocation)
        }
        
        let entry = MapEntry(date: Date(), nearestStations: nearestStations, userLocation: NearbyStationProvider.sampleUserLocation, image: UIImage(systemName: "map")!)
        
        completion(entry)
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<MapEntry>) -> ()) {
        let locations = loadNearestLocations(userLocation: NearbyStationProvider.sampleUserLocation)
        let mapSnapshotter = makeSnapshotter(for: NearbyStationProvider.sampleUserLocation, with: context.displaySize)
            
        mapSnapshotter.start { (snapshot, error) in
            if let snapshot = snapshot {
                let date = Date()
                let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
                let entry = MapEntry(date: date,
                                     nearestStations: locations,
                                     userLocation: NearbyStationProvider.sampleUserLocation,
                                     image: snapshot.image)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                
                completion(timeline)
            }
        }
    }
    
    // MARK: Helpers
    // TODO: Probably put into a networking manager singleton
    private func loadNearestLocations(userLocation: MKCoordinateRegion) -> [Station] {
        // TODO: Should use a network request here.
        let firstNearestLocation = Station(id: "7000", address: "Fort York Blvd / Capreol Ct", bikeCapacity: 5, distance: 0.4)
        let secondNearestLocation = Station(id: "7001", address: "Lower Jarvis St / Mcqueen St E", bikeCapacity: 7, distance: 1.3)
        let thirdNearestLocation = Station(id: "7002", address: "St. George St / Bloor St W", bikeCapacity: 6, distance: 2.3)
        
        return [firstNearestLocation, secondNearestLocation, thirdNearestLocation]
    }
    
    private func makeSnapshotter(for userRegion: MKCoordinateRegion, with size: CGSize) -> MKMapSnapshotter {
        let options = MKMapSnapshotter.Options()
        let halfHeightSize = CGSize(width: size.width, height: size.height / 2)
        
        // TODO: Figure out how to add annotations to map.
        
        options.region = userRegion
        options.size = halfHeightSize
        options.mapType = .standard
        
        // Force light mode snapshot
        options.traitCollection = UITraitCollection(traitsFrom: [
          options.traitCollection,
          UITraitCollection(userInterfaceStyle: .light)
        ])

        return MKMapSnapshotter(options: options)
    }
}

@main
struct BikeshareWidget: Widget {
    let kind: String = "BikeshareWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NearbyStationProvider()) { entry in
            MapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Nearest Bike Stations")
        .description("Show nearest bike stations")
        .supportedFamilies([.systemLarge])
        .onBackgroundURLSessionEvents { (identifier, completion) in
            // TODO: Handle GPS coordinates event?
        }
    }
}

struct BikeshareWidget_Previews: PreviewProvider {
    static var previews: some View {
        MapView(entry: MapEntry(date: Date(),
                                nearestStations: NearbyStationProvider.emptyDataSet,
                                userLocation: NearbyStationProvider.sampleUserLocation,
                                image: UIImage(systemName: "map")!))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

