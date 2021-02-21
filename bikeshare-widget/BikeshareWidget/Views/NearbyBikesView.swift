import SwiftUI

struct NearbyBikesView: View {
    @State var station: Station
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "flag.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color(#colorLiteral(red: 0.7211458683, green: 0.8630903363, blue: 0, alpha: 1)))
                Text(station.address)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .lineLimit(3)
            }
            Spacer()
            HStack {
                Image(systemName: "location.fill")
                    .renderingMode(.template)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6627757549, blue: 0.2614499331, alpha: 1)))
                Text(String(format: "%.2f", station.distance) + "m")
                    .font(.caption)
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 0.5)
            }
            Spacer()
            HStack {
                Image(systemName: "bicycle")
                    .renderingMode(.template)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6627757549, blue: 0.2614499331, alpha: 1)))
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
