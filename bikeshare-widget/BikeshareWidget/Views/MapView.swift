import SwiftUI

struct MapView: View {
    let entry: MapEntry

    var body: some View {
        VStack {
            Image(uiImage: entry.image)
        }
    }
}
