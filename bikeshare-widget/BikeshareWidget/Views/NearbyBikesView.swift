import SwiftUI

struct NearbyBikesView: View {
    @State var station: Station
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "flag.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color("Primary"))
                Text(station.address)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .lineLimit(3)
            }
            Spacer()
            HStack {
                Image(systemName: "location.fill")
                    .renderingMode(.template)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color.green/*@END_MENU_TOKEN@*/)
                Text(String(format: "%.2f", station.distance) + "m")
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 0.5)
            }
            Spacer()
            HStack {
                Image(systemName: "bicycle")
                    .renderingMode(.template)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("Primary-dark")/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 6.0)
                    .frame(width: 18.0)
                Text("\(station.bikeCapacity)")
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 4.0)
            }
           
            
        }
    }
}
