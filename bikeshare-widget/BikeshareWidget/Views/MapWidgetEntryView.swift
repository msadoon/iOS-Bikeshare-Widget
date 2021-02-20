import SwiftUI

struct MapWidgetEntryView : View {
    @State var entry: MapEntry
    private var upperLimitOnNearbyStations: Int {
        entry.nearestStations.count
    }
    
    var body: some View {
        MapView(entry: entry)
        Divider()
        Text("Nearby Bike Stations")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        HStack {
            if upperLimitOnNearbyStations > 0 {
                ForEach(0..<upperLimitOnNearbyStations) {
                    NearbyBikesView(station: entry.nearestStations[$0])
                    Divider()
                }
            } else {
                Text("No Nearby Stations 😭")
                    .font(.caption2)
            }
        }
        .frame(width: entry.image.size.width,
               height: entry.image.size.height - 60,
               alignment: .center)
    }
}
