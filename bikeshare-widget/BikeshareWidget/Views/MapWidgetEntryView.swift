import SwiftUI

struct MapWidgetEntryView : View {
    @State var entry: MapEntry
    private var upperLimitOnNearbyStations: Int {
        entry.nearestStations.count
    }
    
    var body: some View {
        MapView(entry: entry)
            .padding(EdgeInsets(top: -37, leading: 0, bottom: 6, trailing: 0))
        HStack {
            Text("🚲")
                .font(.body)
                .padding(.leading, 16.0)
            Text("Nearby Bike Stations")
                .font(.footnote)
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 6, leading: 0, bottom: 4, trailing: 16))
        }

        HStack {
            if upperLimitOnNearbyStations > 0 {
                ForEach(0..<upperLimitOnNearbyStations) {
                    NearbyBikesView(station: entry.nearestStations[$0])
                    Spacer()
                    Divider()
                }
            } else {
                // TODO: Kylo can put an empty view in.
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
        .frame(width: entry.image.size.width,
               height: entry.image.size.height / 1.6,
               alignment: .center)
    }
}
