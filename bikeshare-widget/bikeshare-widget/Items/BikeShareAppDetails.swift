//
//  BikeShareAppDetails.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct BikeShareAppDetails: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top, 8.0)
            
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    Image(systemName: "flag.fill")
                        .renderingMode(.template)
                        .foregroundColor(Color("Primary"))
                    Text("Station Name")
                        .font(.body)
                }
                Text("Location")
                    .font(.caption)
                    .padding(.bottom, 8.0)
                    .foregroundColor(Color.gray)
                HStack{
                    Image(systemName: "location.fill")
                    Text("1.8 km")
                    Spacer()
                    HStack (alignment: .lastTextBaseline, spacing: 8.0){
                        Image(systemName: "figure.walk")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary-Dark"))
                        Text("6 min")
                        Image(systemName: "car.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary-Dark"))
                        Text("1.3 min")
                    }
                    .frame(alignment: .bottomTrailing)
                }
                .imageScale(.large)
                .font(.footnote)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut lobortis nulla, sed varius augue. ")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.gray)
                Divider()
                    .padding(.vertical, 8.0)
                HStack {
                    HStack {
                        Image(systemName: "bicycle.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary-Dark"))
                            .imageScale(.large)
                        Text("3")
                        Image(systemName: "cart.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary-Dark"))
                        Text("3")
                        Image(systemName: "battery.100.bolt")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary-Dark"))
                        Text("9")
                        
                    }
                    .font(.footnote)
                    .imageScale(.large)
                    Spacer()
                    Button(action: {
                        // What to perform
                        print("direction button tapped")
                    }) {
                        Text("Direction")
                    }
                }
            }
            .padding(.all, 16.0)
        }
        .background(RoundedCorners(color: .white, tl: 22, tr: 22, bl: 0, br: 0))
        //.clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
        .shadow(color: Color("Primary").opacity(0.3), radius:20, x:0, y: 10)
    }
}

struct BikeShareAppDetails_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareAppDetails()
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}
