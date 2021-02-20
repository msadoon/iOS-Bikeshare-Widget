import SwiftUI

struct NearbyBikesView: View {
    @State var station: Station
    
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
