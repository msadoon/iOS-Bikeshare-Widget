import SwiftUI

struct StationRow: View {
    @State var station: Station
    
    var body: some View {
        HStack{
            Image(systemName: "bicycle.circle.fill")
                .renderingMode(.template)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.large)
                .foregroundColor(Color("Primary"))
            
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(station.name)
                                .font(.subheadline)
                                .bold()
                            Text(station.address)
                                .font(.footnote)
                        }
                        
                    }
                    Spacer()
                }
  
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("Primary-Dark"))
                        .imageScale(.large)
                    Text("\(station.distance)")
                    Image(systemName: "bicycle.circle.fill")
                        .foregroundColor(Color("Primary-Dark"))
                    Text("\(station.bikeCapacity)")
                }
                .font(.footnote)
                .foregroundColor(Color.gray)
            }
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .padding(.vertical, 8.0)
    }
}
