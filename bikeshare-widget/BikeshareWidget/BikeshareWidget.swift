import WidgetKit
import SwiftUI
import MapKit
import CoreLocation

struct MapEntry: TimelineEntry {
    let date: Date
    let nearestStations: [Station]
    let userLocation: MKCoordinateRegion
    let image: UIImage
}

struct NearbyStationProvider: TimelineProvider {
    static let emptyLocationSet = [Station]()
    
    // TODO: This is just a failsafe in case location services are not updated on launch
    static var sampleUserLocation: MKCoordinateRegion {
        let latitude = CLLocationDegrees(43.640179)
        let longitude = CLLocationDegrees(-79.393377)
        
        let locationCoord = CLLocationCoordinate2DMake(latitude, longitude)
        
        return MKCoordinateRegion(center: locationCoord,
                                  latitudinalMeters: 500.0,
                                  longitudinalMeters: 500.0)
    }
    
    func placeholder(in context: Context) -> MapEntry {
        MapEntry(date: Date(), nearestStations: NearbyStationProvider.emptyLocationSet, userLocation: NearbyStationProvider.sampleUserLocation, image: UIImage(systemName: "map")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (MapEntry) -> ()) {
        guard !context.isPreview else {
            let mapEntry = MapEntry(date: Date(), nearestStations: NearbyStationProvider.emptyLocationSet, userLocation: NearbyStationProvider.sampleUserLocation, image: UIImage(systemName: "map")!)
            
            completion(mapEntry)
            
            return
        }
        
        let updateCompletionAfterFetchUserLocation: (CLLocation) -> Void = { userLocation in
            contentUpdate(context: context, locations: loadNearestLocations(), updatedUserLocation: userLocation) { mapEntry in
                completion(mapEntry)
            }
        }
        
        LocationManager.shared.fetchLocation(handler: updateCompletionAfterFetchUserLocation)
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<MapEntry>) -> ()) {
        let updateCompletionAfterFetchUserLocation: (CLLocation) -> Void = { userLocation in
            contentUpdate(context: context, locations: loadNearestLocations(), updatedUserLocation: userLocation) { mapEntry in
                let date = Date()
                let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
                let timeline = Timeline(entries: [mapEntry], policy: .after(nextUpdate))
                
                completion(timeline)
            }
        }
        
        LocationManager.shared.fetchLocation(handler: updateCompletionAfterFetchUserLocation)
    }
    
    // MARK: Helpers
    private func contentUpdate(context: TimelineProvider.Context, locations: [Station], updatedUserLocation: CLLocation,  completionHandler: @escaping (MapEntry) -> Void) {
        let region = MKCoordinateRegion(center: updatedUserLocation.coordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
        let mapSnapshotter = makeSnapshotter(for: region, with: context.displaySize)
        
        
        mapSnapshotter.start { (snapshot, error) in
            guard error == nil,
                  let useableSnapShot = snapshot else { return }
            
            let image = UIGraphicsImageRenderer(size: useableSnapShot.image.size).image { _ in
                useableSnapShot.image.draw(at: .zero)
                
                let userLocationIconName = "person.crop.circle.fill"
                let nearestStationIconName = "bicycle"
                
                addAnnotation(snapshot: useableSnapShot, location: updatedUserLocation.coordinate, imageName: userLocationIconName)
                
                locations.forEach {
                    addAnnotation(snapshot: useableSnapShot, location: $0.coordinates, imageName: nearestStationIconName)
                }
            }
            
            let region = MKCoordinateRegion(center: updatedUserLocation.coordinate,
                                            latitudinalMeters: 500.0,
                                            longitudinalMeters: 500.0)
            
            let entry = MapEntry(date: Date(),
                             nearestStations: locations,
                             userLocation: region,
                             image: image)
            
            completionHandler(entry)
        }
    }
    
    private func loadNearestLocations() -> [Station] {
        let latitude1 = CLLocationDegrees(43.639832)
        let longitude1 = CLLocationDegrees(-79.395954)
        let locationCoord1 = CLLocationCoordinate2DMake(latitude1, longitude1)
        
        let latitude2 = CLLocationDegrees(43.64783)
        let longitude2 = CLLocationDegrees(-79.370698)
        let locationCoord2 = CLLocationCoordinate2DMake(latitude2, longitude2)
        
        let latitude3 = CLLocationDegrees(43.66733)
        let longitude3 = CLLocationDegrees(-79.399429)
        let locationCoord3 = CLLocationCoordinate2DMake(latitude3, longitude3)
        
        // TODO: Should use a network request here, sort on nearby_distance and using lat/long for all 500m locations. There should be a way to find all nearest stations to user's current location. Because we have the lat/long data we just need MapKit to find closest lat/long's to user's lat/long. That way we don't rely on nearby_distance.
        let firstNearestLocation = Station(id: "7000", address: "Fort York  Blvd / Capreol Ct", bikeCapacity: 35, distance: 500.0, coordinates: locationCoord1)
        let secondNearestLocation = Station(id: "7001", address: "Lower Jarvis St / The Esplanade", bikeCapacity: 15, distance: 500.0, coordinates: locationCoord2)
        let thirdNearestLocation = Station(id: "7002", address: "St. George St / Bloor St W", bikeCapacity: 19, distance: 500.0, coordinates: locationCoord3)
        
        return [firstNearestLocation, secondNearestLocation, thirdNearestLocation]
    }
    
    private func makeSnapshotter(for userRegion: MKCoordinateRegion, with size: CGSize) -> MKMapSnapshotter {
        let options = MKMapSnapshotter.Options()
        let halfHeightSize = CGSize(width: size.width, height: size.height / 2)
        
        options.region = userRegion
        options.size = halfHeightSize
        options.mapType = .standard
        
        // NOTE: Force light mode snapshot
        options.traitCollection = UITraitCollection(traitsFrom: [
          options.traitCollection,
          UITraitCollection(userInterfaceStyle: .light)
        ])

        return MKMapSnapshotter(options: options)
    }
    
    private func addAnnotation(snapshot: MKMapSnapshotter.Snapshot, location: CLLocationCoordinate2D, imageName: String) {
        let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
        
        pinView.image = UIImage(systemName: imageName)
        
        let pinImage = pinView.image
        
        var point = snapshot.point(for: location)
        
        let containingFrame = CGRect(origin: .zero, size: snapshot.image.size)
        
        if containingFrame.contains(point) {
            point.x -= pinView.bounds.width / 2
            point.y -= pinView.bounds.height / 2
            point.x += pinView.centerOffset.x
            point.y += pinView.centerOffset.y
            
            pinImage?.draw(at: point)
        }
    }
}

@main
struct BikeshareWidget: Widget {
    let kind = "BikeshareWidget"
    let locationManager = CLLocationManager()

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NearbyStationProvider()) { entry in
            MapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Nearest Bike Stations")
        .description("Show nearest bike stations")
        .supportedFamilies([.systemLarge])
    }
}

struct BikeshareWidget_Previews: PreviewProvider {
    static var previews: some View {
        MapView(entry: MapEntry(date: Date(),
                                nearestStations: NearbyStationProvider.emptyLocationSet,
                                userLocation: NearbyStationProvider.sampleUserLocation,
                                image: UIImage(systemName: "map")!))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

