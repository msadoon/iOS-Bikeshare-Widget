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

    private let stationsStore = StationsStoreImpl()
    
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
            loadNearestLocations(userLocation: userLocation) { result in
                switch result {
                case let .success(nearbyStations):
                    contentUpdate(context: context,
                                  locations: nearbyStations,
                                  updatedUserLocation: userLocation) { mapEntry in
                        DispatchQueue.main.async {
                            completion(mapEntry)
                        }
                    }
                case .failure(_):
                    // TODO: Handle error case
                    break
                }
            }
        }
        LocationManager.shared.fetchLocation(handler: updateCompletionAfterFetchUserLocation)
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<MapEntry>) -> ()) {
        let updateCompletionAfterFetchUserLocation: (CLLocation) -> Void = { userLocation in
            loadNearestLocations(userLocation: userLocation) { result in
                switch result {
                case let .success(nearbyStations):
                    contentUpdate(context: context,
                                  locations: nearbyStations,
                                  updatedUserLocation: userLocation) { mapEntry in
                        let date = Date()
                        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
                        let timeline = Timeline(entries: [mapEntry], policy: .after(nextUpdate))

                        DispatchQueue.main.async {
                            completion(timeline)
                        }
                    }
                case .failure(_):
                    // TODO: Handle error case
                    break
                }
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
                let nearestStationIconName = "bicycle.circle.fill"
                
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
    
    private func loadNearestLocations(userLocation: CLLocation, completion: @escaping (Result<[Station], APIError>) -> Void) {
        stationsStore.fetch { result in
            let mappedResult = result.map { stations in
                return closestLocations(userLocation: userLocation, stationLocations: stations)
            }
            completion(mappedResult)
        }
    }
    
    private func closestLocations(userLocation: CLLocation, stationLocations: [Station]) -> [Station] {
        var allDistancesToUser = [(Double, Station)]()
        
        for location in stationLocations {
            let comparableLocation = CLLocation(latitude: location.coordinates.latitude,
                                                longitude: location.coordinates.longitude)
            let distanceToUser = comparableLocation.distance(from: userLocation)
            let distanceAndStation = (distanceToUser, location)
            
            if distanceToUser <= 500 {
                allDistancesToUser.append(distanceAndStation)
            }
        }
        
        let closestStationDistancesToUser = allDistancesToUser.sorted(by: { $0.0 < $1.0 })
        let closestStationsToUser = closestStationDistancesToUser.map({ (accurateDistance, station) -> Station in
            let updatedStationWithDistance = Station(id: station.id,
                                                     name: station.name,
                                                     address: station.address,
                                                     bikeCapacity: station.bikeCapacity,
                                                     distance: accurateDistance,
                                                     coordinates: station.coordinates)
            
            return updatedStationWithDistance
        })
        
        return closestStationsToUser
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

