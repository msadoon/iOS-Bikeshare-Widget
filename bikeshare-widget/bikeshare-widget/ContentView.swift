import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BikeShareAppMap()
            VStack {
                Text("Nearest Bike Stations App")
                    .font(.largeTitle)
                    .padding()
                BikeShareAppDetails()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
