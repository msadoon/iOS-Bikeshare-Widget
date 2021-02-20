import WidgetKit
import SwiftUI
import MapKit

struct Country {
    let name: String
    let capital: String
    var region: MKCoordinateRegion {
        let latitude = CLLocationDegrees(43.651890)
        let longitude = CLLocationDegrees(-79.381706)
        
        let locationCoord = CLLocationCoordinate2DMake(latitude, longitude)
        
        return MKCoordinateRegion(center: locationCoord,
                                  latitudinalMeters: 1000.0,
                                  longitudinalMeters: 1000.0)
    }
}

struct CountryProvider: TimelineProvider {
    static let sampleData = Country(name: "United Kingdom", capital: "London")
    
    func placeholder(in context: Context) -> MapEntry {
        MapEntry(date: Date(), country: CountryProvider.sampleData, image: UIImage())
    }

    func getSnapshot(in context: Context, completion: @escaping (MapEntry) -> ()) {
        let country: Country
        
        if context.isPreview {
            country = CountryProvider.sampleData
        } else {
            country = loadCountries().first ?? CountryProvider.sampleData
        }
        
        let entry = MapEntry(date: Date(), country: country, image: UIImage())
        
        completion(entry)
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<MapEntry>) -> ()) {
        let countries = loadCountries()
        
        if let country = countries.first {
            let mapSnapshotter = makeSnapshotter(for: country, with: context.displaySize)
            
            mapSnapshotter.start { (snapshot, error) in
                if let snapshot = snapshot {
                    let date = Date()
                    let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
                    let entry = MapEntry(date: date, country: country, image: snapshot.image)
                    let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                    
                    completion(timeline)
                }
            }
        }
    }
    
    private func loadCountries() -> [Country] {
        let uk = Country(name: "United Kingdom", capital: "London")
        let canada = Country(name: "Canada", capital: "Toronto")
        let usa = Country(name: "USA", capital: "Washington")
        let mexico = Country(name: "Mexico", capital: "Mexico City")
        let brazil = Country(name: "Brazil", capital: "Sao Paulo")
        
        return [uk, canada, usa, mexico, brazil]
    }
    
    private func makeSnapshotter(for country: Country, with size: CGSize) -> MKMapSnapshotter {
        let options = MKMapSnapshotter.Options()
        let halfHeightSize = CGSize(width: size.width, height: size.height / 2)
        
        options.region = country.region
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

struct MapEntry: TimelineEntry {
    let date: Date
    let country: Country
    let image: UIImage
}

struct CountryEntry: TimelineEntry {
    var date: Date
    var country: Country
}

struct MapWidgetEntryView : View {
    var entry: MapEntry

    var body: some View {
        MapView(entry: entry)
        Divider()
        Text("Nearby Bikes")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        HStack {
            NearbyBikesView(station: Station(address: "Fort York  Blvd / Capreol Ct", bikeCapacity: 35, distance: 500.0))
            Divider()
            NearbyBikesView(station: Station(address: "Lower Jarvis St / The Esplanade", bikeCapacity: 15, distance: 500.0))
            Divider()
            NearbyBikesView(station: Station(address: "St. George St / Bloor St W", bikeCapacity: 19, distance: 500.0))
        }
        .frame(width: entry.image.size.width,
               height: entry.image.size.height - 60,
               alignment: .center)
    }
}

struct Station {
    let address: String
    let bikeCapacity: Int
    let distance: Float
}

struct NearbyBikesView: View {
    var station: Station
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "location.circle")
                Text(station.address)
                    .font(.caption)
            }
            Spacer()
            HStack {
                Image(systemName: "bicycle.circle")
                Text("\(station.bikeCapacity)")
                    .font(.caption)
            }
            Spacer()
            HStack {
                Image(systemName: "mappin.circle")
                Text(String(format: "%.2f", station.distance))
                    .font(.caption)
            }
        }
    }
}

struct MapView: View {
    let entry: MapEntry
    
    var body: some View {
        VStack {
            Image(uiImage: entry.image)
        }
    }
}

@main
struct CountryWidget: Widget {
    let kind: String = "CountryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountryProvider()) { entry in
            MapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Country of the day")
        .description("Show a new country every day")
        .supportedFamilies([.systemLarge])
        .onBackgroundURLSessionEvents { (identifier, completion) in
            // handle event
        }
    }
}

struct CountryWidget_Previews: PreviewProvider {
    static var previews: some View {
        MapView(entry: MapEntry(date: Date(), country: CountryProvider.sampleData, image: UIImage()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

