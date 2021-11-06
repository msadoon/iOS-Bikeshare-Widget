import SwiftUI

struct BikeShareAppStationList: View {
    var body: some View {
            List(0 ..< 20) { item in
                StationRow()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Nearby Stations")
        }
}

struct BikeShareAppStationList_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareAppStationList()
    }
}
