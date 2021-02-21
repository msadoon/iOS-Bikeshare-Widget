import SwiftUI

struct MapWidgetEntryView : View {
    @State var entry: MapEntry
    private var upperLimitOnNearbyStations: Int {
        entry.nearestStations.count
    }
    
    var body: some View {
        MapView(entry: entry)
            .padding(EdgeInsets(top: -37, leading: 0, bottom: 8, trailing: 0))
        //Divider()
        
        Text("Nearby Bike Stations")
            .font(.footnote)
            .foregroundColor(Color.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16))
        HStack {
            if upperLimitOnNearbyStations > 0 {
                ForEach(0..<upperLimitOnNearbyStations) {
                    NearbyBikesView(station: entry.nearestStations[$0])
                    Spacer()
                    Divider()
                }
            } else {
                Text("No Nearby Stations 😭")
                    .font(.caption2)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
        .frame(width: entry.image.size.width,
               height: entry.image.size.height - 80,
               alignment: .center)
    }
}
